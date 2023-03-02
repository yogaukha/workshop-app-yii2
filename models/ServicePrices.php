<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "service_prices".
 *
 * @property string $id
 * @property string $category_id
 * @property string $service_id
 * @property int $price
 * @property int $discount
 * @property string $createdtime
 * @property string $createdby
 * @property string|null $updatedtime
 * @property string|null $updatedby
 * @property int $is_deleted
 */
class ServicePrices extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'service_prices';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['category_id', 'service_id'], 'required', 'message' => 'Wajib diisi'],
            [['price', 'discount', 'is_deleted'], 'integer'],
            [['createdtime', 'updatedtime'], 'safe'],
            [['id', 'category_id', 'service_id'], 'string', 'max' => 36],
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
            'category_id' => 'Kategori',
            'service_id' => 'Jenis Jasa',
            'price' => 'Harga',
            'discount' => 'Diskon',
            'createdtime' => 'Createdtime',
            'createdby' => 'Createdby',
            'updatedtime' => 'Updatedtime',
            'updatedby' => 'Updatedby',
            'is_deleted' => 'Is Deleted',
        ];
    }

    public function getVehicleType()
    {
        return $this->hasOne(VehicleTypes::class, ['id' => 'category_id']);
    }

    public function getService()
    {
        return $this->hasOne(Services::class, ['id' => 'service_id']);
    }
}
