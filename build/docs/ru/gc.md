# ya gc cache

Команда `ya gc cache` предназначена для очистки временных файлов, создаваемых в процессе работы с системой сборки проектов `ya make`.

В ходе сборки проекта генерируются различные промежуточные и вспомогательные файлы, а также результаты сборки, которые хранятся во временных кешах на диске.

Со временем эти файлы могут занимать значительный объем дискового пространства, и их ручное удаление становится неудобным и рискованным процессом.  Команда `ya gc cache` автоматизирует процесс очистки, удаляя устаревшие или ненужные файлы в соответствии с настройками конфигурации.

Предполагается, что большинство файлов по истечении некоторого срока либо будут положены на постоянное хранение, либо могут быть удалены. Это позволяет ограничить потребление дискового пространства.

## Синтаксис

`ya gc cache [OPTIONS]`

`[OPTIONS]` позволяет пользователю указать дополнительные параметры для тонкой настройки процесса очистки. Однако в базовом варианте использования дополнительные параметры не требуются.

### Опции
```
Options:
  Ya operation control
    -h, --help          Print help. Use -hh for more options and -hhh for even more.
    Expert options
    -B=CUSTOM_BUILD_DIRECTORY, --build-dir=CUSTOM_BUILD_DIRECTORY
                        Custom build directory (autodetected by default)
  Local cache
    --cache-stat        Show cache statistics
    --gc                Remove all cache except uids from the current graph
    --gc-symlinks       Remove all symlink results except files from the current graph
    Advanced options
    --tools-cache-size=TOOLS_CACHE_SIZE
                        Max tool cache size (default: 30.0GiB)
    --symlinks-ttl=SYMLINKS_TTL
                        Results cache TTL (default: 0.0h)
    --cache-size=CACHE_SIZE
                        Max cache size (default: 140.04687070846558GiB)
    --cache-codec=CACHE_CODEC
                        Cache codec (default: )
    --auto-clean=AUTO_CLEAN_RESULTS_CACHE
                        Auto clean results cache (default: True)
```

## Автоматическая очистка

Конфигурация очистки кешей может быть настроена локально на машине пользователя через файл конфигурации `~/.ya/ya.conf`.

### Основные функции:

1. Полная очистка вспомогательных файлов — удаление всех файлов, которые хранятся в кеше инструментов и прочих необходимых для сборки данных, которые в нормальном режиме удаляются автоматически.
2. Удаление временных файлов — за исключением файлов, являющимися ссылками на файлы, используемых в других сборках.
3. Фильтрованная очистка локального кеша сборки — используя заданные параметры, позволяет более тонко настраивать процесс удаления данных с диска.

#### Вспомогательные файлы сборки
К вспомогательным файлам сборки относятся компиляторы, SDK, эмуляторы и другие инструменты, которые сами не строятся, но нужны во время запуска `ya` для построения, запуска тестов и т.п. Такие файлы хранятся в кеше инструментов.

Автоматическое удаление настроено на Linux/MacOS.

Политика удаления этих файлов — `LRU`, при ограничении на объем потребляемого дискового пространства. Ограничение по умолчанию может быть переопределено параметром `tools_cache_size`.

Важно, что инструменты удаляются только после завершения всех процессов, которые используют компилятор/эмулятор и т.п, поэтому мгновенное потребление может быть больше ограничения.

Если инструменты запускаются, используя прямые пути, полученные, например, с помощью `ya tool cc --print-path`, то такие инструменты не будут чиститься автоматически, так как система не может контролировать такой сценарий. Такие инструменты автоматически будут очищены в обычном порядке после запуска `ya gc cache`

#### Временные файлы сборки

Можно выделить следующие типы временных файлов сборки:
1. Временные файлы, созданные с помощью функций, производных от `mktemp/mkdtemp` и т.п. Эти файлы создаются во временной директории, которая полностью удаляется в конце работы `ya` (если не указана опция `--keep-temps`).
2. Временные файлы, которые могут быть использованы в других сборках. К ним относятся промежуточные файлы построения, которые описаны в сборке явно через `ya.make` файлы.
Общий размер диска, отведенного для таких файлов, можно ограничить с помощью `cache_size`. Файлы, скачанные из распределенного кеша, тоже относятся к этому типу.
3. Временные файлы, используемые в текущей сборке или директории построения. В большинстве случаев эти файлы являются ссылками на файлы, используемые в других сборках. Такие файлы отнесены в отдельную категорию по нескольким причинам: во-первых, некоторые промежуточные файлы явно запрещено использовать в других сборках, во-вторых, режим сборки с ключом `--rebuild` подразумевает использование исключительно файлов из текущего построения, в-третьих, ограничение по размеру кеша может быть слишком маленьким для текущего построения.
Файлы из этой категории по умолчанию либо удаляются во время текущей сборки, либо во время следующей сборки.

Мгновенное потребление диска за счет файлов из пп. 1 и 3 ограничить заранее нельзя.

Файлы из п.2 хранятся в локальном кеше сборки.

### Основные настройки автоматической очистки файлов:
1. `cache_size` — ограничение на размер [локального кеша](#временные-файлы-сборки).
2. `tools_cache_size` — ограничение на размер [кеша инструментов](#вспомогательные-файлы-сборки).
3. `symlinks_ttl` — ограничение на время жизни результатов сборки, которые кешируются `ya`. Время жизни отсчитывается со времени создания.

Автоматическое удаление можно отключить, задав большие значения для этих параметров, а удаление директорий построения отключается с помощью опции `--keep-temps` системы сборки.

#### Пример настроек в ya.conf
```yaconf
tools_cache_size = "6GiB"
symlinks_ttl = "1h"
cache_size = "80GiB"
```
В данном примере для кеша инструментов установлен предел в 6 ГиБ, время жизни ссылок на результаты сборки — 1 час, и размер локального кеша сборки — 80 ГиБ.

Без кавычек можно задавать размер в байтах или время в секундах, например, `symlinks_ttl = 3600`.

## Ручная очистка
Кроме автоматической очистки кешей можно явно почистить диск с помощью команды `ya gc cache`. Вместе с очисткой делаются дополнительные проверки на ошибки.

Команда полностью удаляет
- все вспомогательные файлы, кроме тех, которые чистятся автоматически;
- все временные файлы, кроме файлов [локального кеша](#временные-файлы-сборки).

### Удаление по размеру и «возрасту»
- `--object-size-limit=OBJECT_SIZE_LIMIT` — удаляет объекты из кеша сборки больше заданного размера (в МиБ).
- `--age-limit=AGE_LIMIT` — удаляет объекты из кеша сборки, которые превышают заданный «возраст» (в часах).

Если не задан фильтр, то будет сделана очистка в соответствии с настройкой `cache_size`.

### Управление сборочными символическими ссылками

- `--gc-symlinks` — очищает репозиторий от устаревших сборочных символических ссылок.

### Примеры практического применения
Удаление крупных объектов кеша
```bash
ya gc cache --object-size-limit=100
```
Очищает кеш от объектов больше 100 МиБ, освобождая значительный объем дискового пространства.

Очистка «старых» объектов кеша
```bash
ya gc cache --age-limit=72
```
Инициирует удаление данных, которые не использовались в течение последних 72 часов, удерживая кеш в актуальном и оптимальном состоянии.
