<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "measurement".
 *
 * @property int $id
 * @property float $temperature
 * @property float $humidity
 * @property float $soil_moisture
 * @property float $illumination
 * @property string $measured_at
 */
class Measurement extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'measurement';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['temperature', 'humidity', 'soil_moisture', 'illumination'], 'required'],
            [['temperature', 'humidity', 'soil_moisture', 'illumination'], 'number'],
            [['measured_at'], 'safe'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => Yii::t('app', 'ID'),
            'temperature' => Yii::t('app', 'Temperature'),
            'humidity' => Yii::t('app', 'Humidity'),
            'soil_moisture' => Yii::t('app', 'Soil Moisture'),
            'illumination' => Yii::t('app', 'Illumination'),
            'measured_at' => Yii::t('app', 'Measured At'),
        ];
    }
}
