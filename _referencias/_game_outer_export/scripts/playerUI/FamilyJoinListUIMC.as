package playerUI
{
   import adobe.utils.*;
   import fl.controls.DataGrid;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1544")]
   public dynamic class FamilyJoinListUIMC extends MovieClip
   {
      
      public var txtRequestMsg:TextField;
      
      public var cmdIsAgreed:MainButton;
      
      public var bgBox:MovieClip;
      
      public var listJoin:DataGrid;
      
      public var cmdNotAgreed:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var txtPlayerName:TextField;
      
      public var cmdClose:SimpleButton;
      
      public function FamilyJoinListUIMC()
      {
         super();
         obf_v_Z_4388();
         obf_0_4_t_706();
         obf_J_U_3240();
      }
      
      internal function obf_v_Z_4388() : *
      {
         try
         {
            listJoin["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         listJoin.allowMultipleSelection = false;
         listJoin.editable = false;
         listJoin.headerHeight = 25;
         listJoin.horizontalLineScrollSize = 4;
         listJoin.horizontalPageScrollSize = 0;
         listJoin.horizontalScrollPolicy = "off";
         listJoin.resizableColumns = false;
         listJoin.rowHeight = 20;
         listJoin.showHeaders = true;
         listJoin.sortableColumns = true;
         listJoin.verticalLineScrollSize = 4;
         listJoin.verticalPageScrollSize = 0;
         listJoin.verticalScrollPolicy = "auto";
         try
         {
            listJoin["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_J_U_3240() : *
      {
         try
         {
            cmdNotAgreed["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdNotAgreed.emphasized = false;
         cmdNotAgreed.enabled = true;
         cmdNotAgreed.label = "obf_____4770";
         cmdNotAgreed.labelPlacement = "right";
         cmdNotAgreed.selected = false;
         cmdNotAgreed.toggle = false;
         cmdNotAgreed.visible = true;
         try
         {
            cmdNotAgreed["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_4_t_706() : *
      {
         try
         {
            cmdIsAgreed["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdIsAgreed.emphasized = false;
         cmdIsAgreed.enabled = true;
         cmdIsAgreed.label = "obf_____4788";
         cmdIsAgreed.labelPlacement = "right";
         cmdIsAgreed.selected = false;
         cmdIsAgreed.toggle = false;
         cmdIsAgreed.visible = true;
         try
         {
            cmdIsAgreed["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

