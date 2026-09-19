# OTUS - High Load

Terraform скрипт для автоматизации установки и настройки виртуальной машины с публичным IP адресом и SSH-доступом в рабочем окружении. 

Для аутентификации и корректного запуска скрипта необходимо.

## Установить terraform (для Fedora OS) 

`sudo dnf install -y dnf-plugins-core`

`sudo dnf config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo`

`sudo dnf -y install terraform`

## Установить YC cli

`curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash`

## Зарегистрироваться в YC

`yc init --username=<электронная_почта>`

А дальше по подсказам скрипта.

## Клонировать ранее созданный репозиторий

`git clone https://github.com/<username>/<reponame>.git`

## Получить токен

`yc iam create-token`

## Подгрузить переменные окружения:

`export FOLDER_NAME=practikum`

`export YC_FOLDER_ID=b1g...........`

`export YC_CLOUD_ID=b1g.............`

`export YC_ZONE=ru-central1-a`

`export YC_TOKEN=t1.....................`

## Указать путь к файлу с публичной частью ключа.

В случае необходимости указать специфический путь к публичной части ключа это можно сделать в файле `main.yml` в блоке `yandex_compute_instance`

По умолчанию указано `"/home/admin/.ssh/id_ed25519"`.

## Файл main.yaml содержит декларативное описание инфраструктуры, а именно:

- информацию о провайдере;
- блок `data` для получения актуальной версии Ubuntu 24.04 LTS;
- блок `variable` со списком TCP портов, которые должны быть доступны у ВМ на уровне политик безопасности;
- блоки `resource` для последовательного создания сети, подсети, группы безопасности и самой ВМ;
- блок `output` для вывода информации о публичном (NAT) статическом IP-адресе.

Ручного указания очередности создания ресурсов нет, так как автоматически выстраиваемый граф зависимостей предполагает единстенную очередность из-за использования в последующих блоках id ресурсов созданных в предыдущих.
В блоке `yandex_compute_instance` есть указание на локальный файл с публичным ключом и используется стандартное имя пользователя, но можно указать в блоке metadata в строке user-data ссылку на cloud-init.yaml в котором указать свое имя пользователя и пр. Например:

```
users:
  - name: user
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1--------------------hQi4/Xp/PpE7ckbo6oM3btG6oEzqvM0RsY fse@localhost.localdomain
```

## Для создания окружения и ВМ необходимо выполнить следующие команды

`terraform init`

`terraform apply`

## Для удаления окружения и ВМ 

`terraform destroy`
















