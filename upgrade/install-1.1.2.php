<?php
/**
 * 2015-2020 Ko_Ondziu
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    Ko_Ondziu <000konrad000@gmail.com>
 * @copyright 2015-2020 Ko_Ondziu
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_1_1_2()
{
    $list_fields = Db::getInstance()->executeS('SHOW FIELDS FROM `'._DB_PREFIX_.'wishlist`');
    if (is_array($list_fields)) {
        foreach ($list_fields as $k => $field) {
            $list_fields[$k] = $field['Field'];
        }
        if (!in_array('default', $list_fields)) {
            return (bool) Db::getInstance()->execute('ALTER TABLE `'._DB_PREFIX_.'wishlist` ADD COLUMN `is_default` INT( 11 ) NOT NULL DEFAULT "0"');
        }
    }
    return true;
}
