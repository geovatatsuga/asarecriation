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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4316")]
   public dynamic class FamilyTaskListUIMC extends MovieClip
   {
      
      public var txtTaskName:TextField;
      
      public var cmdGetTask:MainButton;
      
      public var listTask:DataGrid;
      
      public var bgBox:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var txtTaskRemark:TextField;
      
      public var cmdClose:SimpleButton;
      
      public function FamilyTaskListUIMC()
      {
         super();
         obf_s_b_3150();
         obf_4_4_3861();
      }
      
      internal function obf_4_4_3861() : *
      {
         try
         {
            cmdGetTask["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdGetTask.emphasized = false;
         cmdGetTask.enabled = true;
         cmdGetTask.label = "obf_____4780";
         cmdGetTask.labelPlacement = "right";
         cmdGetTask.selected = false;
         cmdGetTask.toggle = false;
         cmdGetTask.visible = true;
         try
         {
            cmdGetTask["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_s_b_3150() : *
      {
         try
         {
            listTask["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         listTask.allowMultipleSelection = false;
         listTask.editable = false;
         listTask.headerHeight = 25;
         listTask.horizontalLineScrollSize = 4;
         listTask.horizontalPageScrollSize = 0;
         listTask.horizontalScrollPolicy = "off";
         listTask.resizableColumns = false;
         listTask.rowHeight = 20;
         listTask.showHeaders = true;
         listTask.sortableColumns = true;
         listTask.verticalLineScrollSize = 4;
         listTask.verticalPageScrollSize = 0;
         listTask.verticalScrollPolicy = "auto";
         try
         {
            listTask["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

