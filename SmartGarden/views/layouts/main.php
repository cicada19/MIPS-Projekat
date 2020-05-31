<?php

/* @var $this \yii\web\View */
/* @var $content string */

use app\widgets\Alert;
use yii\helpers\Html;
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\widgets\Breadcrumbs;
use app\assets\AppAsset;
use yii\bootstrap\Carousel;
use \yidas\yii\fontawesome\FontawesomeAsset;

AppAsset::register($this);
FontawesomeAsset::register($this);
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
<head>
    <meta charset="<?= Yii::$app->charset ?>">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?php $this->registerCsrfMetaTags() ?>
    <title><?= Html::encode($this->title) ?></title>
    <?php $this->head() ?>
</head>
<body>
<?php $this->beginBody() ?>

<div class="wrap">
    <?php
    echo Carousel::widget([
        'items' => [
            [
                'content' => '<div class="slide1"></div>',
                'caption' => '<h1 class="title-style panel-title">Smart Garden</h1><p class="subtitle-style">Smart gardens are a new popular way to enhance a household living experience with new smart home technology.</p>',
            ],
            [
                'content' => '<div class="slide2"></div>',
                'caption' => '<h1 class="title-style">Smart Garden</h1><p class="subtitle-style">This type of garden is relatively new because the technology hasn\'t existed for an extraordinary period of time yet. </p>',
            ],
            [
                'content' => '<div class="slide3"></div>',
                'caption' => '<h1 class="title-style">Smart Garden</h1><p class="subtitle-style">Smart Garden is the most advanced and easiest indoor gardening solution.</p>',
            ],
            [
                'content' => '<div class="slide4"></div>',
                'caption' => '<h1 class="title-style">Smart Garden</h1><p class="subtitle-style">Indoor gardens equipped with smart technology will help you light, water and nourish plants with minimal fuss.</p>',
            ],
        ]
    ]);

    NavBar::begin([
        'brandLabel' => Yii::$app->name,
        'brandUrl' => Yii::$app->homeUrl,
        'options' => [
            'class' => 'navbar-inverse navbar-br-bg',
        ],
    ]);
    echo Nav::widget([
        'options' => ['class' => 'navbar-nav navbar-right container-fluid'],
        'items' => [
            ['label' => 'Home', 'url' => ['/site/index']],
            ['label' => 'Stastistics', 'url' => ['/measurement/index']],
            ['label' => 'About', 'url' => ['/site/about']],
            ['label' => 'Contact', 'url' => ['/site/contact']],
            Yii::$app->user->isGuest ? (
            ['label' => 'Sign up', 'url' => ['/site/signup']]) : '',
            Yii::$app->user->isGuest ? (
                ['label' => 'Login', 'url' => ['/site/login']]
            ) : (
                '<li>'
                . Html::beginForm(['/site/logout'], 'post')
                . Html::submitButton(
                    'Logout (' . Yii::$app->user->identity->username . ')',
                    ['class' => 'btn btn-link logout']
                )
                . Html::endForm()
                . '</li>'
            ),
        ],

    ]);
    NavBar::end();
    ?>

    <div class="container">
        <?= Breadcrumbs::widget([

            'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
        ]) ?>
        <?= Alert::widget() ?>
        <?= $content ?>
    </div>
</div>

<footer class="footer">
    <div class="container">
        <p class="pull-left">&copy; <a href="https://www.etf.ues.rs.ba/">ETF Istočno Sarajevo</a> <?= date('M, Y') ?></p>
    </div>
</footer>

<?php $this->endBody() ?>
</body>
</html>
<?php $this->endPage() ?>
