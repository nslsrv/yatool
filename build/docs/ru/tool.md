## ya tool

Утилита `ya tool` позволяет пользователям запускать различные инструменты, предоставляемые пакетом `ya`.

### Использование

Для запуска инструмента, предоставляемого утилитой `ya`, используйте следующий синтаксис:

`ya tool <подкоманда> [параметры]`

### Список доступных инструментов

Чтобы получить список доступных инструментов, просто выполните команду: `ya tool`

Эта команда отобразит список инструментов, которые можно выполнить с помощью утилиты:

- `atop` — утилита мониторинга системных процессов.
- `black` — стилизатор Python-кода (только для Python 3).
- `buf` — линтер и детектор изменений для `Protobuf`.
- `c++` — запуск компилятора C++.
- `c++filt` — запуск `c++filt` для преобразования закодированных символов в удобочитаемый формат C++.
- `cc` — запуск компилятора C.
- `clang-format` — запуск стилизатора исходного кода `Clang-Format`.
- `clang-rename` — запуск инструмента рефакторинга `Clang-Rename`.
- `gcov` — запуск программы покрытия тестов `gcov`.
- `gdb` — запуск `GNU Debugger gdb`.
- `gdbnew` — запуск `gdb` для Ubuntu 16.04 или позднее.
- `go` — запуск инструментов Go.
- `gofmt` — запуск стилизатора кода Go `gofmt`.
- `llvm-cov` — запуск утилиты покрытия `LLVM`.
- `llvm-profdata` — запуск утилиты профильных данных `LLVM`.
- `llvm-symbolizer` — запуск утилиты символизации `LLVM`.
- `nm` — запуск утилиты nm для отображения символов из объектных файлов.
- `objcopy` — запуск утилиты `objcopy` для копирования и преобразования бинарных файлов.
- `strip` — запуск утилиты `strip` для удаления символов из бинарных файлов.

### Параметры инструментов ya tool

Чтобы получить подробную информацию о параметрах и аргументах, поддерживаемых каждым инструментом, используйте опцию `-h` с конкретной подкомандой: `ya tool <подкоманда> -h`.

**Пример**
```bash
ya tool buf -h
```
Эта команда предоставит подробное описание использования инструмента, его параметров и примеры.
```bash
Usage:
  buf [flags]
  buf [command]

Available Commands:
  beta            Beta commands. Unstable and will likely change.
  check           Run lint or breaking change checks.
  generate        Generate stubs for protoc plugins using a template.
  help            Help about any command
  image           Work with Images and FileDescriptorSets.
  ls-files        List all Protobuf files for the input location.
  protoc          High-performance protoc replacement.

Flags:
  -h, --help                help for buf
      --log-format string   The log format [text,color,json]. (default "color")
      --log-level string    The log level [debug,info,warn,error]. (default "info")
      --timeout duration    The duration until timing out. (default 2m0s)
  -v, --version             version for buf

Use "buf [command] --help" for more information about a command.
```
### Дополнительные параметры

* `--ya-help` предоставляет информацию об использовании конкретного инструмента, запускаемого через `ya tool`.
Синтаксис команды: `ya tool <подкоманда> --ya-help`.
* `--print-path` используется для вывода пути к исполняемому файлу конкретного инструмента, запускаемого через утилиту `ya tool`. Параметр позволяет пользователю узнать точное местоположение инструмента на файловой системе. Например, чтобы получить путь к исполняемому файлу инструмента `clang-format`, выполните следующую команду: `ya tool clang-format --print-path`.
* `--force-update` используется для проверки наличия обновлений и обновления конкретного инструмента, запускаемого через утилиту `ya tool`. Например, чтобы принудительно обновить и затем запустить инструмент `go`, используйте следующую команду: `ya tool go --force-update`.
