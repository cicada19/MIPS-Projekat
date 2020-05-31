<?php

use yii\helpers\Html;

/* @var $this yii\web\View */

$this->title = 'Smart garden - Home page';
$mainTitle = "Welcome to my smart garden";
$subtitle = "Last measurements taken at: ";

?>


<h1 class="text-center"><?= Html::encode($mainTitle) ?></h1><br>
<?= $this->render('../dashboard', ['model' => $model]); ?>
<h4 class="text-center"><?= Html::encode($subtitle) . \Yii::$app->formatter->asDatetime($model['measured_at'], 'd-M-Y H:m:s') ?></h4>
