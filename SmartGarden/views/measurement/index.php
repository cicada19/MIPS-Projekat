<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\MeasurementSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Smart garden - Measurements';
$this->params['breadcrumbs'][] = "Measurements";
?>
<div class="measurement-index">

    <h1><?= Html::encode("Measurements") ?></h1><br>
<div style="overflow-x:auto;">
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'tableOptions' =>
            [
                'class' => 'table table-sm table-condensed table-responsive'
            ],

        'layout'=>"{items}\n{summary}\n{pager}",
        'columns' => [
            ['class' => 'yii\grid\SerialColumn',
                'headerOptions' => ['style' => 'width:5%']],


            [
                'attribute' => 'temperature',
                'headerOptions' => ['style' => 'text-align: center;'],
                'contentOptions' => ['style' => 'text-align: center;'],
                'value' => function($model)
                {
                    return $model->temperature.' °C';
                }
            ],
            [
                'attribute' => 'humidity',
                'headerOptions' => ['style' => 'text-align: center;'],
                'contentOptions' => ['style' => 'text-align: center;'],
                'value' => function($model)
                {
                    return $model->humidity.' %';
                }
            ],
            [
                'attribute' => 'soil_moisture',
                'headerOptions' => ['style' => 'text-align: center;'],
                'contentOptions' => ['style' => 'text-align: center;'],
                'value' => function($model)
                {
                    return $model->soil_moisture.' %';
                }
            ],
            [
                'attribute' => 'illumination',
                'headerOptions' => ['style' => 'text-align: center;'],
                'contentOptions' => ['style' => 'text-align: center;'],
                'value' => function($model)
                {
                    return $model->illumination.' %';
                }
            ],
            [
                    'format' => 'raw',
                'attribute' => 'measured_at',
                'headerOptions' => ['style' => 'text-align: center;'],
                'contentOptions' => ['style' => 'text-align: center;'],
                'value' => function ($model) {
                    return \Yii::$app->formatter->asDate($model->measured_at, 'd-M-Y').' <b style="margin: 0 2% 0 2%">at</b> '.\Yii::$app->formatter->asTime($model->measured_at, 'H:m:s');
                }
            ],


            ['class' => 'yii\grid\ActionColumn',

                'template' => '{view}',
                'contentOptions' => ['style' => 'text-align: right;'],
            ],
        ],

    ]); ?>


</div>
</div>
