<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "customers".
 *
 * @property string $id
 * @property string $license_plate
 * @property string $name
 * @property string $address
 * @property string $phone_number
 * @property string $email
 * @property string $brand
 * @property string $type
 * @property string $color
 * @property string $year
 * @property int $kilometre
 * @property string|null $engine_number
 * @property string|null $vehicle_identification_number
 * @property string $createdtime
 * @property string $createdby
 * @property string|null $updatedtime
 * @property string|null $updatedby
 * @property int $is_deleted
 */
class Customers extends \yii\db\ActiveRecord
{
    public $counter;
    public $category_name;

    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'customers';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['category_id', 'license_plate', 'name', 'address', 'phone_number', 'brand', 'type', 'color', 'year', 'kilometre'], 'required', 'message' => 'Wajib diisi'],
            [['address'], 'string'],
            [['kilometre', 'is_deleted'], 'integer'],
            [['createdtime', 'updatedtime'], 'safe'],
            [['id', 'category_id'], 'string', 'max' => 36],
            [['license_plate'], 'string', 'max' => 11],
            [['name'], 'string', 'max' => 300],
            [['phone_number'], 'string', 'max' => 14],
            [['email', 'brand', 'type', 'color', 'engine_number', 'vehicle_identification_number', 'createdby', 'updatedby'], 'string', 'max' => 100],
            [['year'], 'string', 'min' => 4, 'max' => 4],
            [['license_plate'], 'unique'],
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
            'license_plate' => 'Nomor Polisi',
            'name' => 'Nama',
            'address' => 'Alamat',
            'phone_number' => 'Nomor Telepon',
            'email' => 'Email',
            'brand' => 'Merk',
            'type' => 'Tipe',
            'color' => 'Warna',
            'year' => 'Tahun',
            'kilometre' => 'KM',
            'engine_number' => 'Nomor Mesin',
            'vehicle_identification_number' => 'Nomor Rangka',
            'createdtime' => 'Createdtime',
            'createdby' => 'Createdby',
            'updatedtime' => 'Updatedtime',
            'updatedby' => 'Updatedby',
            'is_deleted' => 'Is Deleted',
            'category_id' => 'Kategori',
            'category_name' => 'Kategori Mobil'
        ];
    }

    public function fields()
    {
        $fields = array_merge(parent::fields(), ['counter', 'category_name']);

        return $fields;
    }
}
