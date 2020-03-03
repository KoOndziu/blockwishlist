{*
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
*}

{extends file="helpers/list/list_content.tpl"}

{block name="td_content"}
  {if isset($params.type) && $params.type == 'priority'}
    <span class="label label-default">{$priority[$tr.$key]}</span>
  {elseif isset($params.type) && $params.type == 'image'}
    <img src="{$tr.$key}"/>
  {else}
    {$smarty.block.parent}
  {/if}
{/block}
