# Infrastructure Automation Blueprint

![CI/CD Pipeline](https://github.com/RM7hsh/infrastructure-automation-blueprint/actions/workflows/ci.yml/badge.svg)

Учебный инфраструктурный проект, который демонстрирует практический подход к автоматизации Linux-инфраструктуры с использованием **Terraform**, **Ansible**, **Docker Compose** и **GitHub Actions CI/CD**.

Проект показывает не только готовую структуру, но и реальный рабочий процесс: первоначальная реализация, ошибки в CI/CD, анализ логов GitHub Actions, исправление проблем в Terraform, Ansible и Docker Compose, повторный запуск pipeline и успешное прохождение проверок.

---

## Цель проекта

Главная цель — показать навыки инфраструктурной автоматизации и DevOps-подхода на понятном и воспроизводимом примере.

Проект охватывает:

- описание инфраструктуры через Terraform;
- настройку серверов через Ansible;
- развёртывание сервисов через Docker Compose;
- проверку кода через GitHub Actions;
- исправление ошибок по логам CI/CD;
- аккуратную структуру репозитория и понятную историю коммитов.

---

## Технологии

- **Linux**
- **Terraform**
- **Ansible**
- **Docker Compose**
- **GitHub Actions**
- **PostgreSQL**
- **Nginx**
- **YAML**
- **Infrastructure as Code**
- **CI/CD**

---

## Структура репозитория

```text
.
├── ansible/
│   ├── inventory/
│   │   └── development.yml
│   ├── playbooks/
│   │   └── site.yml
│   └── roles/
│       ├── common/
│       ├── web/
│       └── db/
├── docker/
│   └── docker-compose.yml
├── docs/
│   └── architecture.md
├── terraform/
│   ├── main.tf
│   └── variables.tf
├── .github/
│   └── workflows/
│       └── ci.yml
├── .gitignore
└── README.md
```

---

## Что делает проект

### Terraform

В директории `terraform/` находится пример описания виртуальной машины для Proxmox:

- провайдер Proxmox;
- параметры подключения;
- описание виртуальной машины;
- настройка cloud-init;
- SSH-ключи;
- сеть;
- параметры CPU/RAM.

Terraform здесь используется как пример подхода **Infrastructure as Code**, когда инфраструктура описывается кодом и может быть воспроизведена повторно.

---

### Ansible

В директории `ansible/` находится структура Ansible-проекта:

- inventory для development-среды;
- основной playbook;
- роль `common` для базовой настройки сервера;
- роль `web` для установки и настройки Nginx;
- роль `db` для установки и настройки PostgreSQL.

В проекте используются:

- `ansible.builtin.apt`;
- `ansible.builtin.service`;
- `ansible.builtin.template`;
- `community.postgresql.postgresql_db`;
- `community.postgresql.postgresql_user`;
- `community.postgresql.postgresql_privs`.

Отдельное внимание уделено правилам `ansible-lint`: корректные имена задач, `become: true`, FQCN-модули, права файлов, правильный YAML-формат и отсутствие лишних пустых строк.

---

### Docker Compose

В директории `docker/` находится `docker-compose.yml`, который поднимает тестовый стек:

- PostgreSQL;
- Nginx;
- отдельную Docker-сеть;
- volume для хранения данных PostgreSQL.

Docker Compose используется для демонстрации контейнеризации и проверки конфигурации через CI/CD.

---

### GitHub Actions CI/CD

В проекте настроен pipeline GitHub Actions:

```yaml
.github/workflows/ci.yml
```

Pipeline проверяет:

- форматирование Terraform;
- Ansible-код через `ansible-lint`;
- корректность Docker Compose build.

Это позволяет автоматически проверять качество инфраструктурного кода при каждом push.

---

## История исправления CI/CD

В проекте специально сохранена история разработки, где видно, как pipeline сначала падал, а затем был исправлен.

Во время первых запусков CI/CD возникали ошибки:

### Terraform

```text
terraform fmt -check -recursive
main.tf
Error: Terraform exited with code 3.
```

Причина:

- неправильное форматирование `main.tf`;
- лишнее выравнивание;
- устаревшая строковая интерполяция `"${var.web_password}"`.

Исправление:

- Terraform-код был приведён к стандартному стилю;
- `cipassword = "${var.web_password}"` заменено на `cipassword = var.web_password`;
- файл отформатирован под `terraform fmt`.

---

### Ansible

Ошибки `ansible-lint`:

```text
Use FQCN for builtin module actions
Truthy value should be one of [false, true]
All plays should be named
become_user should have a corresponding become
File permissions unset or incorrect
No new line character at the end of file
Too many blank lines
```

Причины:

- модули `apt`, `service`, `template` использовались без `ansible.builtin`;
- использовались `yes/no` вместо `true/false`;
- playbook не имел имени;
- рядом с `become_user` отсутствовал `become: true`;
- для template-файла не был указан `mode`;
- в некоторых YAML-файлах были лишние или отсутствующие пустые строки в конце.

Исправления:

- добавлены FQCN-модули;
- `yes` заменён на `true`;
- добавлены имена для playbook и задач;
- добавлен `become: true` рядом с `become_user`;
- для шаблона Nginx добавлен `mode: "0644"`;
- исправлены завершающие строки в YAML-файлах.

---

### Docker Compose

Ошибка:

```text
failed to solve: failed to read dockerfile: open Dockerfile: no such file or directory
```

Причина:

- в `docker-compose.yml` использовался `build: .`, но Dockerfile отсутствовал.

Исправление:

- вместо `build: .` используется готовый образ `nginx:alpine`;
- убрано устаревшее поле `version`;
- переменные окружения заменены на явные значения для тестового CI-стенда.

---

## Итог

После исправлений pipeline проходит успешно.

Этот проект показывает не просто знание отдельных инструментов, а полный цикл работы с инфраструктурным репозиторием:

1. Создание структуры проекта.
2. Написание Terraform, Ansible и Docker Compose.
3. Настройка CI/CD.
4. Запуск pipeline.
5. Анализ ошибок.
6. Исправление Terraform, Ansible и Docker Compose.
7. Повторная проверка.
8. Получение зелёного CI.

---

## Как запустить проверки локально

### Terraform

```bash
cd terraform
terraform fmt -check -recursive
```

### Ansible

```bash
cd ansible
ansible-lint
```

### Docker Compose

```bash
docker compose -f docker/docker-compose.yml build
```

---

## Пример Git workflow

Проект удобно развивать через отдельные ветки:

```bash
git checkout -b feature/add-monitoring
```

После изменений:

```bash
git add .
git commit -m "Add monitoring stack"
git push origin feature/add-monitoring
```

Далее можно открыть Pull Request и дождаться прохождения CI/CD.

---

## Что демонстрирует проект работодателю

Этот репозиторий показывает, что я умею:

- работать с Git и GitHub;
- читать и исправлять ошибки GitHub Actions;
- писать инфраструктурный код;
- использовать Terraform;
- писать Ansible-роли и playbook;
- исправлять замечания `ansible-lint`;
- работать с Docker Compose;
- понимать CI/CD-процесс;
- доводить pipeline до зелёного состояния;
- оформлять инфраструктурный проект в понятную структуру.

---

## Автор

**Рахимов Раджабали**  
GitHub: [https://github.com/RM7hsh](https://github.com/RM7hsh)

Студент направления «Сетевое и системное администрирование».  
Интересы: Linux, российские ОС, системное администрирование, сети, Ansible, Terraform, Docker, мониторинг и инфраструктурная автоматизация.

---

## License

MIT License

