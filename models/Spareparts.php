<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "spareparts".
 *
 * @property string $id
 * @property string $name
 * @property int|null $price
 * @property string $createdtime
 * @property string $createdby
 * @property string|null $updatedtime
 * @property string|null $updatedby
 * @property int $is_deleted
 */
class Spareparts extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'spareparts';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name'], 'required', 'message' => 'Wajib diisi'],
            [['name'], 'string'],
            [['price', 'is_deleted'], 'integer'],
            [['createdtime', 'updatedtime'], 'safe'],
            [['id'], 'string', 'max' => 36],
            [['createdby', 'updatedby'], 'string', 'max' => 100],
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
            'name' => 'Nama',
            'price' => 'Harga',
            'createdtime' => 'Createdtime',
            'createdby' => 'Createdby',
            'updatedtime' => 'Updatedtime',
            'updatedby' => 'Updatedby',
            'is_deleted' => 'Is Deleted',
        ];
    }
}
