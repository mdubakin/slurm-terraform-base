Итоговый проект
=======

Задание
-------

В рамках курса мы разобрали все основные абстракции `Terraform`, научились работать с ресурсами, переменными, управляющими структурами и датасурсами, изучили основные подходы к управлению инфраструктурой с помощью `Terraform`. Создали по шагам собственный проект с нуля, постепенно улучшая его, развили до максимального удобства использования с применением всех лучших практик.

Теперь мы предлагаем закрепить полученные навыки и собрать еще один проект. В нем вам будет предложено познакомиться с новым типом ресурсов в облаке, а так же немного поработать с `Packer`. Это задание демонстрирует наиболее хороший на наш взгляд подход к деплою приложений в облаке.

1. Создайте новую директорию `slurm-tf-final-project/`

2. В ней создайте две директории: `packer/` и `terraform/`

3. В директорию `packer/` скопируйте `Ansible` роль из задания предыдущего модуля

4. В этой же директории создайте файл `nginx.pkr.hcl`

5. Используя материалы из вебинара про `Packer` и документацию `Yandex Cloud` опишите образ вм с установленным из `Ansible` роли `nginx`

6. Соберите образ в `Yandex Cloud` с именем `nginx-x-y-z` (где `x` это числовой тэг, проставляемый из переменных пакера в момент сборки)

    Пример: в конфигурации `Packer` объявляется переменная `image_tag`, далее она используется как

    ```ini
    image_name = "nginx-${var.image_tag}"
    ```

    и ее значение передается при запуске `Packer` с помощью ключа `-var`:

    ```ini
    packer build -var 'image_tag=1'
    ```

7. В директории `terraform/` опишите деплой инфраструктуры с сетью, тремя подсетями по одной в зоне доступности и инстанс группой.

    > Обратите внимание, что для работы инстанс группы также нужно создать ресурс yandex_iam_service_account (сервисная учетная запись, нужная для управления инстанс группой виртуальными машинами, см. документацию) и дать ему роль editor с помощью еще одного ресурса yandex_resourcemanager_folder_iam_binding.

    Не забывайте использовать подходы и практики, показанные в курсе:

    * Называйте ресурсы, создаваемые в единственном числе "**this**"
    * Создайте переменные нужных типов для управления параметрами виртуальных машин и остальной инфраструктуры
    * Добавьте ветвление со значениями по умолчанию там где это необходимо
    * Используйте `count` и `for_each` для создания нескольких экземпляров одного ресурса

8. Добавьте возможность указания имени образа, тэга образа (нужно конкатенировать переменные с именем и тэгом в одну строку), а так же количества виртуальных машин

9. Опишите `application load balancer` для инстанс группы и все необходимые для него подресурсы

10. Добавьте вывод внешнего IP балансировщика с помощью `outputs`

11. Задеплойте проект, проверите в UI облака или с помощью `yc`, что ресурсы создались, таргеты у балансировщика находятся в активном состоянии. Выполните запрос на IP балансировщика, проверьте, что вм отвечают.

12. После выполнения задания не забудьте удалить созданную инфраструктуру и продолжить освоение Terraform :)

> При удалении у вас может возникнуть проблема с тем, что виртуальные машины инстанс группы не удаляются из `terraform` и операция `destroy` никогда не завершается. Вспомните, что говорилось в видео о зависимостях ресурсов – это происходит, так как `terraform` сначала удаляет ресурс `yandex_resourcemanager_folder_iam_binding`, так как он никак не связан с ресурсом инстанс группы, а потом, при удалении самой инстанс группы, ее сервисный аккаунт уже не обладает необходимыми правами для управления своими виртуальными машинами. Подумайте как можно исправить данное поведение.
