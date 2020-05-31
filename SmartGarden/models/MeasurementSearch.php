<?php

namespace app\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Measurement;

/**
 * MeasurementSearch represents the model behind the search form of `app\models\Measurement`.
 */
class MeasurementSearch extends Measurement
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id'], 'integer'],
            [['temperature', 'humidity', 'soil_moisture', 'illumination'], 'number'],
            [['measured_at'], 'safe'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = Measurement::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => [
            'pageSize' => 10],
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'temperature' => $this->temperature,
            'humidity' => $this->humidity,
            'soil_moisture' => $this->soil_moisture,
            'illumination' => $this->illumination,
            'measured_at' => $this->measured_at,
        ]);

        return $dataProvider;
    }
}
