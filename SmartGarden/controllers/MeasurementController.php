<?php

namespace app\controllers;

use Yii;
use app\models\Measurement;
use app\models\MeasurementSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\AccessControl;

/**
 * MeasurementController implements the CRUD actions for Measurement model.
 */
class MeasurementController extends Controller
{
    /**
     * {@inheritdoc}
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['index', 'view'],
                'rules' => [
                    [
                        'actions' => ['view', 'index'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
        ];
    }

    /**
     * Lists all Measurement models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new MeasurementSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Measurement model.
     * @param integer $id
     * @return mixed
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    public function actionInsert()
    {
        $this->enableCsrfValidation = false;
        $model = new Measurement();
        $isInserted = false;

        $model->measured_at = time();
        if($model->load(Yii::$app->request->post()) && $model->save())
        {
            $isInserted = true;
        }

        return $this->render('insert', ['model' => $model, 'isInserted' => $isInserted]);
    }



    /**
     * Finds the Measurement model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Measurement the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Measurement::findOne($id)) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
