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

function upgrade_module_0_3($object)
{
    return ($object->registerHook('displayProductListFunctionalButtons') && $object->registerHook('top'));
}
