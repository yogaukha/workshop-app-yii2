<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "work_orders".
 *
 * @property string $id
 * @property string $customer_id
 * @property string $number nomor PKB
 * @property int $status
 * @property string $entry_date
 * @property string|null $completion_date
 * @property string $service_advisor
 * @property string $createdtime
 * @property string $createdby
 * @property string $updatedtime
 * @property string $updatedby
 * @property int $is_deleted
 */
class WorkOrders extends \yii\db\ActiveRecord
{
    public $customer_name;
    public $customer_license_plate;
    public $counter;
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'work_orders';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['number', 'status'], 'required', 'message' => 'Wajib diisi'],
            [['is_deleted', 'total_service', 'total_sparepart', 'grand_total'], 'integer'],
            [['createdtime', 'updatedtime'], 'safe'],
            [['entry_date', 'completion_date',], 'default', 'value' => null],
            [['id', 'customer_id'], 'string', 'max' => 36],
            [['number'], 'string', 'max' => 11],
            [['service_advisor', 'createdby', 'updatedby', 'status'], 'string', 'max' => 100],
            [['customer_complaints'], 'string'],
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
            'customer_id' => 'Nama Pelanggan',
            'number' => 'Nomor PKB',
            'status' => 'Status',
            'entry_date' => 'Tanggal Masuk',
            'completion_date' => 'Tanggal Keluar',
            'service_advisor' => 'Service Advisor',
            'customer_complaints' => 'Keluhan Pelanggan',
            'createdtime' => 'Createdtime',
            'createdby' => 'Createdby',
            'updatedtime' => 'Updatedtime',
            'updatedby' => 'Updatedby',
            'is_deleted' => 'Is Deleted',
            'customer_name' => 'Nama Pelanggan',
            'customer_license_plate' => 'Nomor Polisi'
        ];
    }

    public function fields()
    {
        $fields = array_merge(parent::fields(), ['customer_name', 'customer_license_plate', 'counter']);

        return $fields;
    }

    public function getCustomer()
    {
        return $this->hasOne(Customers::class, ['id' => 'customer_id']);
    }

    public function getWorkOrderDetail()
    {
        return $this->hasMany(WorkOrderDetails::class, ['work_order_id' => 'id']);
    }
}
