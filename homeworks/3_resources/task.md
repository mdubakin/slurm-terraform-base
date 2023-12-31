# 3. Ресурсы

- [3. Ресурсы](#3-ресурсы)
- [Работа с ресурсами](#работа-с-ресурсами)
  - [Задание](#задание)
- [Структура проекта](#структура-проекта)
  - [Задание](#задание-1)
- [Внесение изменений в конфигурацию налету](#внесение-изменений-в-конфигурацию-налету)
  - [Задание](#задание-2)
- [Внесение изменений в конфигурацию с перезагрузкой](#внесение-изменений-в-конфигурацию-с-перезагрузкой)
  - [Задание](#задание-3)
- [Импорт инфраструктуры в state](#импорт-инфраструктуры-в-state)
  - [Задание](#задание-4)

Работа с ресурсами
=======

Задание
-------

В этом задании мы научимся использовать ресурсы провайдера, напишем свою собственную конфигурацию для создания инфраструктуры.

Сохраните проект, который мы создадим в этом задании. В последствии мы будем его дорабатывать.

1. Создайте новую директорию для проекта

2. Создайте файл `main.tf` в этой директории

3. Опишите в этом файле создание сети и трех её подсетей, по одной в зоне доступности. Также не забудьте про секцию `terraform` и `providers`

4. Примените полученную конфигурацию с помощью команды:

    ```
    terraform apply
    ```

    Не забудьте сделать `terraform init` в новой директории

5. Проверьте, что ресурсы действительно создались в облаке

6. После завершения задания удалите созданную инфраструктуру с помощью команды:

    ```
    terraform destroy
    ```

Структура проекта
=======

Задание
-------

В рамках данного задания вы научитесь разделять проект на отдельные файлы для удобства чтения и редактирования больших инфраструктур.

1. Разделите свой проект из предыдущего задания на отдельные файлы - `providers`, `compute`, `network`; перенесите части описания инфраструктуры в нужные файлы

2. Добавьте создание виртуальных машин к вашему проекту, по одной в каждой подсети (и зоне доступности соответственно)

3. Примените конфигурацию. Проверьте, что инфраструктура действительно создалась в облаке

4. После завершения задания не забудьте удалить созданную инфраструктуру

Внесение изменений в конфигурацию налету
=======

Задание
-------

В следующих двух заданиях посмотрим на то, как терраформ применяет конфигурацию. Рассмотрим два примера – изменения, которые подхватываются "налету" и изменения, для которых нужна перезагрузка виртуальной машины.

Стоит помнить также, что при работе с терраформом возможны изменения только с пересозданием объектов инфраструктуры. Всегда обращайте внимание на вывод команды terraform plan перед внесением изменений.

1. Создайте инфраструктуру в облаке из вашего проекта для предыдущего задания.

2. Добавьте метки (`labels`) `project=slurm`, `env=lab` на подсети из предыдущего задания.

3. Примените конфигурацию еще раз. Если все сделано правильно, `Terraform` должен внести изменения без пересоздания подсетей.

4. Проверьте наличие меток в UI консоли облака или с помощью утилиты `yc`.

Внесение изменений в конфигурацию с перезагрузкой
=======

Задание
-------

1. Измените описание виртуальных машин из прошлого задания, увеличив количество CPU и памяти на машинах.

2. Добавьте нужный параметр в конфигурацию виртуальных машин, чтобы было разрешение для `Terraform` перезагружать виртуальную машину для внесения изменений (см лекцию).

3. Примените конфигурацию еще раз. В случае, если все сделано правильно, `Terraform` должен выключить виртуальные машины, внести изменения и запустить их обратно.

4. Проверьте, что параметры виртуальных машин действительно изменились и они находятся в запущенном состоянии.

5. После завершения задания удалите созданную инфраструктуру.

Импорт инфраструктуры в state
=======

Задание
-------

В этом задании вы научитесь импортировать уже созданную инфраструктуру из облака в state `Terraform`. Это одна из самых распространенных задач, когда вы начинаете внедрять `Terraform` в работу своей компании. Знание как импортировать инфраструктуру в state может выручить вас, если со state что-то случится.

1. Создайте инфраструктуру из проекта, который вы делали в предыдущих заданиях.

2. После создания удалите файлы `terraform.tfstate` и `terraform.tfstate.backup`

3. Импортируйте созданную инфраструктуру из облака с помощью команды:

    ```
    terraform import <resource type>.<resource name> <resourece id from cloud>
    ```

4. После завершения импорта всех объектов примените инфраструктуру еще раз. Если все сделано верно, `Terraform` должен завершить работу успешно, не внося каких либо изменений.

5. После завершения задания удалите созданную инфраструктуру.
