#PHPCHAT EXAMPLE
PHPとNodeJSを連携させてチャット機能を作るやつのサンプルアプリ。

## install
1. ``cd node``
1. ``npm install``
1. ``coffee connect.coffee`` (or ``node connect.js``)
1. ``cd ../nginx/``
1. ``cp phpchat_example.conf.example phpchat_example.conf``
1. modify ``phpchat_example.conf`` and include on ``/etc/nginx/nginx.conf``
1. ``cd ../app``
1. ``composer install`` (or ``php composer.phar install``)
1. ``php artisan migrate``
1. modify ``'key'`` parameter in ``app/app/config/app.php``
1. Access on browser!