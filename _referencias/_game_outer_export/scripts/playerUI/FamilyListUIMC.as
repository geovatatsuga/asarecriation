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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2414")]
   public dynamic class FamilyListUIMC extends MovieClip
   {
      
      public var familyList:DataGrid;
      
      public var cmdClose:SimpleButton;
      
      public var cmdJoin:MainButton;
      
      public var bgBox:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var titleBox:MovieClip;
      
      public var cmdCreate:MainButton;
      
      public var cmdView:MainButton;
      
      public function FamilyListUIMC()
      {
         super();
         obf_T_l_3639();
         obf_P_n_1784();
         obf_H_W_1343();
         obf_O_y_3087();
      }
      
      internal function obf_O_y_3087() : *
      {
         try
         {
            cmdCreate["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCreate.emphasized = false;
         cmdCreate.enabled = true;
         cmdCreate.label = "obf_____4832";
         cmdCreate.labelPlacement = "right";
         cmdCreate.selected = false;
         cmdCreate.toggle = false;
         cmdCreate.visible = true;
         try
         {
            cmdCreate["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_P_n_1784() : *
      {
         try
         {
            cmdJoin["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdJoin.emphasized = false;
         cmdJoin.enabled = true;
         cmdJoin.label = "obf_____4764";
         cmdJoin.labelPlacement = "right";
         cmdJoin.selected = false;
         cmdJoin.toggle = false;
         cmdJoin.visible = true;
         try
         {
            cmdJoin["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_H_W_1343() : *
      {
         try
         {
            cmdView["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdView.emphasized = false;
         cmdView.enabled = true;
         cmdView.label = "obf_____4798";
         cmdView.labelPlacement = "right";
         cmdView.selected = false;
         cmdView.toggle = false;
         cmdView.visible = true;
         try
         {
            cmdView["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_T_l_3639() : *
      {
         try
         {
            familyList["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         familyList.allowMultipleSelection = false;
         familyList.editable = false;
         familyList.headerHeight = 25;
         familyList.horizontalLineScrollSize = 4;
         familyList.horizontalPageScrollSize = 0;
         familyList.horizontalScrollPolicy = "off";
         familyList.resizableColumns = false;
         familyList.rowHeight = 20;
         familyList.showHeaders = true;
         familyList.sortableColumns = true;
         familyList.verticalLineScrollSize = 4;
         familyList.verticalPageScrollSize = 0;
         familyList.verticalScrollPolicy = "auto";
         try
         {
            familyList["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

