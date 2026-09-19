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

## Файл main.yaml содержит:

- информацию о провайдере;
- блок `data` для получения актуальной версии ОС;
- блок `variable` со списком портов, которые должны быть доступны у ВМ;
- блоки `resource` для последовательного создания сети, подсети, группы безопасности и самой ВМ;
- блок `output` для вывода информации о статическом IP-адресе.

## Для создания окружения и ВМ необходимо выполнить следующие команды

`terraform init`

`terraform apply`

















