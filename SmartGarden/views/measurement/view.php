<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\Measurement */

$this->title = "Smart garden - Measurement";
$this->params['breadcrumbs'][] = ['label' => 'Measurements', 'url' => ['index']];
$this->params['breadcrumbs'][] = "Measurement";

?>
<div class="p-2">

    <h1><?= Html::encode("Measurement") ?></h1><br>
    <?= DetailView::widget([
        'model' => $model,
        'options' => [
                'class' => ['table table-condensed table-sm table-bordered']

                ],
        'attributes' => [
            [
                'attribute' => 'temperature',
                'contentOptions' => ['style' => 'text-align: center;'],
                'value' => function($model)
                {
                    return $model->temperature.' °C';
                }
            ],
            [
                'attribute' => 'humidity',
                'contentOptions' => ['style' => 'text-align: center;'],
                'value' => function($model)
                {
                    return $model->humidity.' %';
                }
            ],
            [
                'attribute' => 'soil_moisture',
                'contentOptions' => ['style' => 'text-align: center;'],
                'value' => function($model)
                {
                    return $model->soil_moisture.' %';
                }
            ],
            [
                'attribute' => 'illumination',
                'contentOptions' => ['style' => 'text-align: center;'],
                'value' => function($model)
                {
                    return $model->illumination.' %';
                }
            ],
            [
                'format' => 'raw',
                'attribute' => 'measured_at',
                'contentOptions' => ['style' => 'text-align: center;'],
                'value' => function ($model) {
                    return \Yii::$app->formatter->asDate($model->measured_at, 'd-M-Y').'
                            <b style="margin: 0 1% 0 1%">at</b> '.\Yii::$app->formatter->asTime($model->measured_at, 'H:m:s');
                }
            ],
        ],
    ]) ?>
</div>
<?= $this->render('../dashboard', ['model' => $model]); ?>

