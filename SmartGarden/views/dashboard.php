<?php

use yii\helpers\Html;

?>

<div class="row">
    <div class="col-md-3">
        <div class="dbox dbox--color-1">
            <div class="dbox__icon">
                <i class="custom-icon"><img src="../icons/temperature-24.ico"></i>
            </div>
            <div class="dbox__body">
                <span class="dbox__count"><?= Html::encode($model['temperature']) ?> °C</span>
                <span class="dbox__title">Temperature</span>
            </div>

            <div class="dbox__action">
                <button class="dbox__action__btn">Go to statistics</button>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="dbox dbox--color-2">
            <div class="dbox__icon">
                <i class="custom-icon pb-5"><img src="../icons/sun-icon-18-24.png"></i>
            </div>
            <div class="dbox__body">
                <span class="dbox__count"><?= Html::encode($model['illumination']) ?>%</span>
                <span class="dbox__title">Illumination</span>
            </div>

            <div class="dbox__action">
                <button class="dbox__action__btn">Go to statistics</button>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="dbox dbox--color-3">
            <div class="dbox__icon">
                <i class="glyphicon glyphicon-tint"></i>
            </div>
            <div class="dbox__body">
                <span class="dbox__count"><?= Html::encode($model['humidity']) ?>%</span>
                <span class="dbox__title">Humidity</span>
            </div>

            <div class="dbox__action">
                <button class="dbox__action__btn">Go to statistics</button>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="dbox dbox--color-4">
            <div class="dbox__icon">
                <i class="glyphicon glyphicon-leaf"></i>
            </div>
            <div class="dbox__body">
                <span class="dbox__count"><?= Html::encode($model['soil_moisture']) ?>%</span>
                <span class="dbox__title">Soil moisture</span>
            </div>

            <div class="dbox__action">
                <button class="dbox__action__btn">Go to statistics</button>
            </div>
        </div>
    </div>
    <br>
</div>

<?php
$js = <<< 'EOD'
$('.dbox__action__btn').click(function(){
 window.location.href='../measurement/index';
});
EOD;
$this->registerJs($js);

?>