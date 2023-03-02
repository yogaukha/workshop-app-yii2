<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "roles".
 *
 * @property string $id
 * @property string $name
 * @property string $createdtime
 * @property string $createdby
 * @property string|null $updatedtime
 * @property string|null $updatedby
 * @property int $is_deleted
 */
class Roles extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'roles';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'name', 'createdby'], 'required', 'message' => 'Wajib diisi'],
            [['createdtime', 'updatedtime'], 'safe'],
            [['is_deleted'], 'integer'],
            [['id'], 'string', 'max' => 36],
            [['name', 'createdby', 'updatedby'], 'string', 'max' => 100],
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
            'createdtime' => 'Createdtime',
            'createdby' => 'Createdby',
            'updatedtime' => 'Updatedtime',
            'updatedby' => 'Updatedby',
            'is_deleted' => 'Is Deleted',
        ];
    }
}
