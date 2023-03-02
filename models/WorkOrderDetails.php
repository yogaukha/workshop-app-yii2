<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "work_order_details".
 *
 * @property string $id
 * @property string $work_order_id
 * @property string $service_id
 * @property string|null $sparepart_id
 * @property int|null $manual_price 
 * @property int|null $manual_discount 
 * @property string $createdtime
 * @property string $createdby
 * @property string|null $updatedtime
 * @property string|null $updatedby
 * @property int $is_deleted
 */
class WorkOrderDetails extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'work_order_details';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            // [['work_order_id', 'service_id'], 'required', 'message' => 'Wajib diisi'],
            [['subtotal'], 'required', 'message' => 'Wajib diisi'],
            [['manual_price', 'manual_discount', 'subtotal', 'is_deleted'], 'integer', 'message' => 'Angka harus bulat'], 
            [['createdtime', 'updatedtime'], 'safe'],
            [['id', 'work_order_id', 'service_id', 'sparepart_id'], 'string', 'max' => 36],
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
            'work_order_id' => 'Nomor PKB',
            'service_id' => 'Jasa',
            'sparepart_id' => 'Sparepart',
            'manual_price' => 'Harga',
            'manual_discount' => 'Diskon',
            'subtotal' => 'Subtotal',
            'createdtime' => 'Createdtime',
            'createdby' => 'Createdby',
            'updatedtime' => 'Updatedtime',
            'updatedby' => 'Updatedby',
            'is_deleted' => 'Is Deleted',
        ];
    }

    public function getWorkDetail()
    {
        return $this->hasOne(WorkDetails::class, ['id' => 'work_order_id']);
    }

    public function getServicePrice()
    {
        return $this->hasOne(ServicePrices::class, ['id' => 'service_id']);
    }

    public function getSparepart()
    {
        return $this->hasOne(Spareparts::class, ['id' => 'sparepart_id']);
    }
}
