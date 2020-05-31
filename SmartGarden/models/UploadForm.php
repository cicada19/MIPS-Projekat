<?php
/**
 * Created by PhpStorm.
 * User: ewo
 * Date: 1/19/2020
 * Time: 4:21 PM
 */

namespace app\models;

use yii\base\Model;
use yii\web\UploadedFile;

class UploadForm extends Model
{
    /**
     * @var UploadedFile
     */
    public $imageFile;

    public function rules()
    {
        return [
            [['imageFile'], 'file', 'skipOnEmpty' => true, 'extensions' => 'png, jpg'],
        ];
    }
    public function attributeLabels()
    {
        return
        [
            'imageFile' => 'Emblem image'
        ];
    }

    public function upload()
    {
        if ($this->validate()) {
            if($this->imageFile !== null) {
                $this->imageFile->saveAs('../web/images/clubLogos/' . $this->imageFile->baseName . '.' . $this->imageFile->extension);
            }
            return true;
        } else {
            return false;
        }
    }
}