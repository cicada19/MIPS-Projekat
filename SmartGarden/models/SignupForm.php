<?php
/**
 * Created by PhpStorm.
 * User: ewo
 * Date: 1/15/2020
 * Time: 8:32 PM
 */

namespace app\models;

use yii\base\Model;
use yii\helpers\VarDumper;


class SignupForm extends Model
{

    public $username;
    public $password;
    public $password_repeat;

    public function rules()
    {
        return [

            [['username', 'password', 'password_repeat'], 'required'],
            ['username', 'string', 'min' => 4, 'max' => 16],
            [['password', 'password_repeat'], 'string', 'min' => 8],
            ['password_repeat', 'compare', 'compareAttribute' => 'password'],
            ['username', 'validateUsername'],
        ];
    }

    public function signup()
    {

        $user = new User();

        if($this->validate())
        {
            $user->username = $this->username;
            $user->password = \Yii::$app->security->generatePasswordHash($this->password);
            $user->auth_key = \Yii::$app->security->generateRandomString();
            $user->token = \Yii::$app->security->generateRandomString();

            if ($user->save())
            {
                return true;
            }
            \Yii::error('User data are not saved.'. VarDumper::dumpAsString($user->errors));
        }
        return false;
    }

    public function validateUsername($attribute, $params)
    {
        if(User::findByUsername($this->username) !== null)
        {
            $this->addError($attribute, 'This username is already taken !');
        }
    }
}