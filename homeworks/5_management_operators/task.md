# 5. Управляющие структуры

- [5. Управляющие структуры](#5-управляющие-структуры)
- [Ветвление](#ветвление)
  - [Задание](#задание)
- [Убираем дублирование из проекта](#убираем-дублирование-из-проекта)
  - [Задание](#задание-1)
- [Итерация по списку](#итерация-по-списку)
  - [Задание](#задание-2)
- [Динамические блоки](#динамические-блоки)
  - [Задание](#задание-3)

Ветвление
=======

Задание
-------

Отработаем использование тернарного оператора – научим плейбук генерировать пару SSH ключей, если пользователь не указал публичный SSH ключ для виртуальных машин.

Мы продолжим дорабатывать проект из предыдущих модулей.

1. Объявите переменную `public_ssh_key_path`

2. Создайте в проекте отдельный файл `keys.tf` и в нем опишите ресурс `tls_private_key` с алгоритмом `RSA`. Не забудьте добавить в `providers.tf` провайдер `tls`

3. Добавьте в ресурсы виртуальных машин возможность выбора – либо пользователь указал переменную `public_ssh_key_path`, либо использовать публичный ключ, сгенерированный в `tls_private_key`

4. Добавьте `output` `private_ssh_key` для приватной части ключа. Тут тоже нужно добавить ветвление. Если пользователь указал публичный ключ сам, то выводить пустую строку. При применении конфигурации у вас может возникнуть ошибка с приватными данными. Поправьте ее так, как говорит terraform.

5. Примените конфигурацию без указание пути к публичному ключу. Для просмотра `sensitive` данных в `output` можно воспользоваться командой:

    ```
    terraform output -json
    # или
    terraform output -raw
    ```

6. Сохраните приватный ключ, проверьте, что можете с ним подключиться к виртуальным машинам по SSH

7. Проверьте, что работает второй вариант, когда пользователь указывает путь к ключу

8. После завершения задания удалите созданную инфрастурктуру

Убираем дублирование из проекта
=======

Задание
-------

В этом задании уберем дублирование ресурсов из проекта. Благодаря мета-аргументу `count` можно создавать любое количество одинаковых объектов из одного ресурса. Поэтому не имеет смысла описывать несколько ресурсов `yandex_compute_instance`.

Давайте обновим проект, с которым мы работаем в курсе.

1. Оставьте в проекте только один ресурс `yandex_compute_instance`.

2. Добавьте к нему мета-аргумент `count` со значением `3`.

3. Поменяйте именование виртуальных машин в облаке, чтобы к их именам при создании дописывался `index`.

4. Добавьте переменную `az` типа `list` со списком зон доступности в Yandex Cloud:

    ```
    ru-central1-a, ru-central1-b, ru-central1-c
    ```

5. Измените конфигурацию виртуальных машин, чтобы брать имя зоны доступности для виртуальной машины из переменной `az`. Каждая виртуальная машина должна находиться в своей зоне доступности.

6. Так же как и для виртуальных машин оставьте только один ресурс - `subnet`,  в нем укажите мета-аргумент `count` со значением `3`.

7. Реализуйте создание подсети в каждой зоне доступности (как было показано в уроке), принимая список IPv4 CIDR из переменной `cidr_blocks`, содержащей список списков подсетей для каждого из сабнетов.

8. Измените ресурс `yandex_lb_target_group`, чтобы туда попадали виртуальные машины по индексу.

9. Примените конфигурацию, проверьте что все ресурсы именуются правильно.

10. После завершения задания не забудьте удалить инфраструктуру.

Итерация по списку
=======

Задание
-------

В этом уроке показывалось как можно используя мета-аргумент `for_each` изменить создание подсетей, чтобы они создавались на основе списка зон доступности в облаке. Это более подходящий вариант для работы с подсетями, так как он позволяет динамически создавать или удалять объекты при изменении списка зон доступности. Так же в этом задании мы разрешим пользователю создавать любое количество виртуальных машин и автоматически распределять их по имеющимся подсетям и зонам.

1. Реализуйте для ресурса `subnet` итерацию по списку подсетей, так как было показано в видео.

2. Добавьте переменную `vm_count` типа `number`.

3. Измените конфигурацию `yandex_compute_instance`, чтобы создавать столько виртуальных машин, сколько указано в переменной. Пока не будем трогать создание таргет группы в балансере. В следующем уроке научимся динамически добавлять в нее созданные виртуальные машины, вне зависимости от их количества. Для выполнения текущего задания можете временно переименовать файл с конфигурацией балансировщика в `.tf.back`, чтобы Terraform не видел этот файл.

4. Добавьте распределение по зонам доступности и подсетям как было показано в видео с помощью операции остатка от деления. В качестве делителя используйте длину списка `az`:

    ```
    length(az)
    ```

5. Проверьте работу конфигурации. В том числе попробуйте убрать из переменной `az` одну зону.

При этом вы должны увидеть, что автоматически удаляется одна подсеть, а виртуальные машины перераспределяются по оставшимся.

6. После завершения задания удалите созданную инфраструктуру

Динамические блоки
=======

Задание
-------

В этом задании научимся использовать блок `dynamic` для генерации повторяющихся блоков опций в ресурсах.

Хороший способ потренироваться в использовании `dynamic` это динамическое добавление таргетов в таргет группу балансировщика. Она как раз принимает повторяющиеся блоки `target` для каждой виртуальной машины.

1. Добавьте в конфигурацию таргет группы для балансировщика `dynamic` блок с таргетами, так как было показано в видео. Для итерации используйте список созданных виртуальных машин. Для получения адреса и `subnet_id` для каждого таргета используйте следующие атрибуты вм:

    ```
    network_interface.0.subnet_id
    network_interface.0.ip_address
    ```

2. Проверьте работу плейбука. Попробуйте изменить количество виртуальных машин после первого применения конфигурации. Если все сделано верно, новая виртуальная машина должна автоматически добавляться в таргет группу балансировщика.

3. После выполнения задания удалите созданную инфраструктуру