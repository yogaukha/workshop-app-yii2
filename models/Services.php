<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "services".
 *
 * @property string $id
 * @property string $name
 * @property string $createdtime
 * @property string $createdby
 * @property string|null $updatedtime
 * @property string|null $updatedby
 * @property int $is_deleted
 */
class Services extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'services';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name'], 'required', 'message' => 'Wajib diisi'],
            [['name'], 'string'],
            [['createdtime', 'updatedtime'], 'safe'],
            [['is_deleted'], 'integer'],
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
            'name' => 'Nama Jasa',
            'createdtime' => 'Createdtime',
            'createdby' => 'Createdby',
            'updatedtime' => 'Updatedtime',
            'updatedby' => 'Updatedby',
            'is_deleted' => 'Is Deleted',
        ];
    }

    public function getServicePrice()
    {
        return $this->hasMany(ServicePrices::class, ['work_order_id' => 'id']);
    }
}
