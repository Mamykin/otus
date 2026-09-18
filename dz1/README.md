# otus

Terraform скрипт для автоматизации установки и настройки виртуальной машины с публичным IP адресом и SSH-доступом в рабочем окружении. 

Для аутентификации и корректного запуска скрипта необходимо.

Установить terraform (для Fedora OD) 
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install terraform

Клонировать ранее созданный репозиторий
git clone https://github.com/<username>/<reponame>.git
подгрузить переменные окружения:

export FOLDER_NAME=practikum

export YC_FOLDER_ID=b1g...........

export YC_CLOUD_ID=b1g.............

export YC_ZONE=ru-central1-a

export YC_TOKEN=t1.....................


