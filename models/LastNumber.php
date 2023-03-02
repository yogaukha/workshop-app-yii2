<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "last_number".
 *
 * @property string $id
 * @property int $last_work_order_number
 */
class LastNumber extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'last_number';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['last_work_order_number'], 'required'],
            [['last_work_order_number'], 'integer'],
            [['id'], 'string', 'max' => 36],
            [['id'], 'unique'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'last_work_order_number' => 'Nomor Terakhir',
        ];
    }
}
