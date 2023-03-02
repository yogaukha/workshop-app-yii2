<?php

namespace app\models;

use Yii;
use yii\web\UploadedFile;

/**
 * This is the model class for table "generals".
 *
 * @property string $id
 * @property string $name
 * @property string $value
 * @property string $createdtime
 * @property string $createdby
 * @property string|null $updatedtime
 * @property string|null $updatedby
 * @property int $is_deleted
 */
class Generals extends \yii\db\ActiveRecord
{
    public $image;
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'generals';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name'], 'required', 'message' => 'Wajib diisi'],
            [['type'], 'required', 'message' => 'Wajib dipilih'],
            [['createdtime', 'updatedtime', 'image'], 'safe'],
            [['is_deleted'], 'integer'],
            [['id'], 'string', 'max' => 36],
            [['name', 'createdby', 'updatedby', 'type'], 'string', 'max' => 100],
            [['value'], 'string', 'max' => 300],
            [['id'], 'unique'],
            [['image'], 'file', 'skipOnEmpty' => true, 'extensions' => 'png']
        ];
    }

    public function fields()
    {
        $fields = array_merge(parent::fields(), ['image']);

        return $fields;
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Nama',
            'value' => 'Isian',
            'image' => 'File Gambar',
            'createdtime' => 'Createdtime',
            'createdby' => 'Createdby',
            'updatedtime' => 'Updatedtime',
            'updatedby' => 'Updatedby',
            'is_deleted' => 'Is Deleted',
        ];
    }
    
    public function upload()
    {
        if ($this->validate()) {
            $path = 'uploads/' . $this->image->baseName . '.' . $this->image->extension;
            $this->image->saveAs($path);
            return $path;
        } else {
            return false;
        }
    }
}
