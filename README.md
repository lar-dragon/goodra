# Goodra

This is a simple scripts to automatise work witch [Laradock](https://laradock.io/) on whole projects.

## Usage

This script development for usage witch git, docker and docker-compose utilities.
You may run it from your PATH as Unix BASH or Windows CMD script by `goodra` name.
Specific project Laradock initialised into your PWD in `./goodra` or user specific `~/.goodra` catalog by PWD basename.
By default, `DATA_PATH_HOST` configured to save state in Laradock project place.
Scrip defines some Laradock environments:

* `APP_CODE_PATH_HOST` as current PWD.
* `COMPOSE_PROJECT_NAME` as project name.
* `PHP_IDE_CONFIG` preset `serverName` as project name.

Also, append new environments to Laradock project:

* `LARADOCK_ORIGIN` is Laradock source repository link.
* `LARADOCK_BRANCH` is Laradock source repository tag.
* `LARADOCK_SERVICES` is Laradock services list for up. By default, `workspace` only.

### Commands

```shell script
goodra ${project:="."} ${command:="init"} ${arguments}
```

First argument is a Laradock project name.
By default, is a `.` (PWD basename).
Second argument is a command to apply on Laradock project.
It's specific a `.sh` file name.
By default, is a `init` (Laradock project initialise).
Another arguments will receive a command script.

#### `init` - Laradock project initialise

```shell script
goodra . init
```

or

```shell script
goodra .
```

or

```shell script
goodra
```

This command apply default Laradock preset (from `default` catalog) and initialised Git repository.
If files already exists they will use by priority.

```shell script
goodra myLaradock init
```

or

```shell script
goodra myLaradock
```

Against `myLaradock` you may specific your own Laradock project name.
This command also initialised Laradock, but for user specific `~/.goodra/myLaradock` catalog.
Command use `LARADOCK_ORIGIN` and `LARADOCK_BRANCH` environments from Laradock `.env`.

#### `up` - Up Laradock services

```shell script
goodra . up
```

This command call `docker-compose up` with Laradock project environments preset.
Command use `LARADOCK_SERVICES` environment from Laradock `.env`.
Also, as `init` this command may applied for user specific Laradock project.

#### `exec` - Execute command on Laradock workspace container

```shell script
goodra . exec bash
```

or

```shell script
goodra . exec
```

This command call `docker-compose exec` on Laradock workspace container as `laradock` user.
By default, command specific `bash` in arguments.
Also, as `init` this command may applied for user specific Laradock project.

#### `down` - Down Laradock services

```shell script
goodra . down
```

This command call `docker-compose down` on Laradock project.
Also, as `init` this command may applied for user specific Laradock project.

## Extending

Laradock presets witch project named branch, so keep changes in Git.
All existing `.sh` files in Laradock project may used as commands by name.
Command scripts will receive environments from Laradock `.env` file.
