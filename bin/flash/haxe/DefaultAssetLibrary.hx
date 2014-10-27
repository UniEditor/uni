package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("styles/default/circle.png", __ASSET__styles_default_circle_png);
		type.set ("styles/default/circle.png", AssetType.IMAGE);
		className.set ("styles/default/collapse.png", __ASSET__styles_default_collapse_png);
		type.set ("styles/default/collapse.png", AssetType.IMAGE);
		className.set ("styles/default/cross.png", __ASSET__styles_default_cross_png);
		type.set ("styles/default/cross.png", AssetType.IMAGE);
		className.set ("styles/default/expand.png", __ASSET__styles_default_expand_png);
		type.set ("styles/default/expand.png", AssetType.IMAGE);
		className.set ("styles/default/up_down.png", __ASSET__styles_default_up_down_png);
		type.set ("styles/default/up_down.png", AssetType.IMAGE);
		className.set ("styles/gradient/arrow_down.png", __ASSET__styles_gradient_arrow_down_png);
		type.set ("styles/gradient/arrow_down.png", AssetType.IMAGE);
		className.set ("styles/gradient/arrow_down_dark.png", __ASSET__styles_gradient_arrow_down_dark_png);
		type.set ("styles/gradient/arrow_down_dark.png", AssetType.IMAGE);
		className.set ("styles/gradient/arrow_down_disabled.png", __ASSET__styles_gradient_arrow_down_disabled_png);
		type.set ("styles/gradient/arrow_down_disabled.png", AssetType.IMAGE);
		className.set ("styles/gradient/arrow_left.png", __ASSET__styles_gradient_arrow_left_png);
		type.set ("styles/gradient/arrow_left.png", AssetType.IMAGE);
		className.set ("styles/gradient/arrow_left_disabled.png", __ASSET__styles_gradient_arrow_left_disabled_png);
		type.set ("styles/gradient/arrow_left_disabled.png", AssetType.IMAGE);
		className.set ("styles/gradient/arrow_right.png", __ASSET__styles_gradient_arrow_right_png);
		type.set ("styles/gradient/arrow_right.png", AssetType.IMAGE);
		className.set ("styles/gradient/arrow_right2.png", __ASSET__styles_gradient_arrow_right2_png);
		type.set ("styles/gradient/arrow_right2.png", AssetType.IMAGE);
		className.set ("styles/gradient/arrow_right_dark.png", __ASSET__styles_gradient_arrow_right_dark_png);
		type.set ("styles/gradient/arrow_right_dark.png", AssetType.IMAGE);
		className.set ("styles/gradient/arrow_right_disabled.png", __ASSET__styles_gradient_arrow_right_disabled_png);
		type.set ("styles/gradient/arrow_right_disabled.png", AssetType.IMAGE);
		className.set ("styles/gradient/arrow_up.png", __ASSET__styles_gradient_arrow_up_png);
		type.set ("styles/gradient/arrow_up.png", AssetType.IMAGE);
		className.set ("styles/gradient/arrow_up_disabled.png", __ASSET__styles_gradient_arrow_up_disabled_png);
		type.set ("styles/gradient/arrow_up_disabled.png", AssetType.IMAGE);
		className.set ("styles/gradient/circle_dark.png", __ASSET__styles_gradient_circle_dark_png);
		type.set ("styles/gradient/circle_dark.png", AssetType.IMAGE);
		className.set ("styles/gradient/cross_dark.png", __ASSET__styles_gradient_cross_dark_png);
		type.set ("styles/gradient/cross_dark.png", AssetType.IMAGE);
		className.set ("styles/gradient/cross_dark_disabled.png", __ASSET__styles_gradient_cross_dark_disabled_png);
		type.set ("styles/gradient/cross_dark_disabled.png", AssetType.IMAGE);
		className.set ("styles/gradient/gradient.css", __ASSET__styles_gradient_gradient_css);
		type.set ("styles/gradient/gradient.css", AssetType.TEXT);
		className.set ("styles/gradient/gradient.min.css", __ASSET__styles_gradient_gradient_min_css);
		type.set ("styles/gradient/gradient.min.css", AssetType.TEXT);
		className.set ("styles/gradient/gradient_mobile.css", __ASSET__styles_gradient_gradient_mobile_css);
		type.set ("styles/gradient/gradient_mobile.css", AssetType.TEXT);
		className.set ("styles/gradient/gradient_mobile.min.css", __ASSET__styles_gradient_gradient_mobile_min_css);
		type.set ("styles/gradient/gradient_mobile.min.css", AssetType.TEXT);
		className.set ("styles/gradient/gripper_horizontal.png", __ASSET__styles_gradient_gripper_horizontal_png);
		type.set ("styles/gradient/gripper_horizontal.png", AssetType.IMAGE);
		className.set ("styles/gradient/gripper_horizontal_disabled.png", __ASSET__styles_gradient_gripper_horizontal_disabled_png);
		type.set ("styles/gradient/gripper_horizontal_disabled.png", AssetType.IMAGE);
		className.set ("styles/gradient/gripper_vertical.png", __ASSET__styles_gradient_gripper_vertical_png);
		type.set ("styles/gradient/gripper_vertical.png", AssetType.IMAGE);
		className.set ("styles/gradient/gripper_vertical_disabled.png", __ASSET__styles_gradient_gripper_vertical_disabled_png);
		type.set ("styles/gradient/gripper_vertical_disabled.png", AssetType.IMAGE);
		className.set ("styles/windows/accordion.css", __ASSET__styles_windows_accordion_css);
		type.set ("styles/windows/accordion.css", AssetType.TEXT);
		className.set ("styles/windows/accordion.min.css", __ASSET__styles_windows_accordion_min_css);
		type.set ("styles/windows/accordion.min.css", AssetType.TEXT);
		className.set ("styles/windows/button.png", __ASSET__styles_windows_button_png);
		type.set ("styles/windows/button.png", AssetType.IMAGE);
		className.set ("styles/windows/buttons.css", __ASSET__styles_windows_buttons_css);
		type.set ("styles/windows/buttons.css", AssetType.TEXT);
		className.set ("styles/windows/buttons.min.css", __ASSET__styles_windows_buttons_min_css);
		type.set ("styles/windows/buttons.min.css", AssetType.TEXT);
		className.set ("styles/windows/calendar.css", __ASSET__styles_windows_calendar_css);
		type.set ("styles/windows/calendar.css", AssetType.TEXT);
		className.set ("styles/windows/checkbox.png", __ASSET__styles_windows_checkbox_png);
		type.set ("styles/windows/checkbox.png", AssetType.IMAGE);
		className.set ("styles/windows/container.png", __ASSET__styles_windows_container_png);
		type.set ("styles/windows/container.png", AssetType.IMAGE);
		className.set ("styles/windows/glyphs/down_arrow.png", __ASSET__styles_windows_glyphs_down_arrow_png);
		type.set ("styles/windows/glyphs/down_arrow.png", AssetType.IMAGE);
		className.set ("styles/windows/glyphs/hscroll_thumb_gripper_down.png", __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_down_png);
		type.set ("styles/windows/glyphs/hscroll_thumb_gripper_down.png", AssetType.IMAGE);
		className.set ("styles/windows/glyphs/hscroll_thumb_gripper_over.png", __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_over_png);
		type.set ("styles/windows/glyphs/hscroll_thumb_gripper_over.png", AssetType.IMAGE);
		className.set ("styles/windows/glyphs/hscroll_thumb_gripper_up.png", __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_up_png);
		type.set ("styles/windows/glyphs/hscroll_thumb_gripper_up.png", AssetType.IMAGE);
		className.set ("styles/windows/glyphs/left_arrow.png", __ASSET__styles_windows_glyphs_left_arrow_png);
		type.set ("styles/windows/glyphs/left_arrow.png", AssetType.IMAGE);
		className.set ("styles/windows/glyphs/right_arrow.png", __ASSET__styles_windows_glyphs_right_arrow_png);
		type.set ("styles/windows/glyphs/right_arrow.png", AssetType.IMAGE);
		className.set ("styles/windows/glyphs/up_arrow.png", __ASSET__styles_windows_glyphs_up_arrow_png);
		type.set ("styles/windows/glyphs/up_arrow.png", AssetType.IMAGE);
		className.set ("styles/windows/glyphs/vscroll_thumb_gripper_down.png", __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_down_png);
		type.set ("styles/windows/glyphs/vscroll_thumb_gripper_down.png", AssetType.IMAGE);
		className.set ("styles/windows/glyphs/vscroll_thumb_gripper_over.png", __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_over_png);
		type.set ("styles/windows/glyphs/vscroll_thumb_gripper_over.png", AssetType.IMAGE);
		className.set ("styles/windows/glyphs/vscroll_thumb_gripper_up.png", __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_up_png);
		type.set ("styles/windows/glyphs/vscroll_thumb_gripper_up.png", AssetType.IMAGE);
		className.set ("styles/windows/hprogress.png", __ASSET__styles_windows_hprogress_png);
		type.set ("styles/windows/hprogress.png", AssetType.IMAGE);
		className.set ("styles/windows/hscroll.png", __ASSET__styles_windows_hscroll_png);
		type.set ("styles/windows/hscroll.png", AssetType.IMAGE);
		className.set ("styles/windows/listview.css", __ASSET__styles_windows_listview_css);
		type.set ("styles/windows/listview.css", AssetType.TEXT);
		className.set ("styles/windows/listview.min.css", __ASSET__styles_windows_listview_min_css);
		type.set ("styles/windows/listview.min.css", AssetType.TEXT);
		className.set ("styles/windows/listview.png", __ASSET__styles_windows_listview_png);
		type.set ("styles/windows/listview.png", AssetType.IMAGE);
		className.set ("styles/windows/menus.css", __ASSET__styles_windows_menus_css);
		type.set ("styles/windows/menus.css", AssetType.TEXT);
		className.set ("styles/windows/optionbox.png", __ASSET__styles_windows_optionbox_png);
		type.set ("styles/windows/optionbox.png", AssetType.IMAGE);
		className.set ("styles/windows/popup.png", __ASSET__styles_windows_popup_png);
		type.set ("styles/windows/popup.png", AssetType.IMAGE);
		className.set ("styles/windows/popups.css", __ASSET__styles_windows_popups_css);
		type.set ("styles/windows/popups.css", AssetType.TEXT);
		className.set ("styles/windows/rtf.css", __ASSET__styles_windows_rtf_css);
		type.set ("styles/windows/rtf.css", AssetType.TEXT);
		className.set ("styles/windows/scrolls.css", __ASSET__styles_windows_scrolls_css);
		type.set ("styles/windows/scrolls.css", AssetType.TEXT);
		className.set ("styles/windows/scrolls.min.css", __ASSET__styles_windows_scrolls_min_css);
		type.set ("styles/windows/scrolls.min.css", AssetType.TEXT);
		className.set ("styles/windows/sliders.css", __ASSET__styles_windows_sliders_css);
		type.set ("styles/windows/sliders.css", AssetType.TEXT);
		className.set ("styles/windows/tab.png", __ASSET__styles_windows_tab_png);
		type.set ("styles/windows/tab.png", AssetType.IMAGE);
		className.set ("styles/windows/tabs.css", __ASSET__styles_windows_tabs_css);
		type.set ("styles/windows/tabs.css", AssetType.TEXT);
		className.set ("styles/windows/textinput.png", __ASSET__styles_windows_textinput_png);
		type.set ("styles/windows/textinput.png", AssetType.IMAGE);
		className.set ("styles/windows/vprogress.png", __ASSET__styles_windows_vprogress_png);
		type.set ("styles/windows/vprogress.png", AssetType.IMAGE);
		className.set ("styles/windows/vscroll.png", __ASSET__styles_windows_vscroll_png);
		type.set ("styles/windows/vscroll.png", AssetType.IMAGE);
		className.set ("styles/windows/windows.css", __ASSET__styles_windows_windows_css);
		type.set ("styles/windows/windows.css", AssetType.TEXT);
		className.set ("img/slinky.jpg", __ASSET__img_slinky_jpg);
		type.set ("img/slinky.jpg", AssetType.IMAGE);
		className.set ("img/slinky_large.jpg", __ASSET__img_slinky_large_jpg);
		type.set ("img/slinky_large.jpg", AssetType.IMAGE);
		className.set ("img/slinky_small.jpg", __ASSET__img_slinky_small_jpg);
		type.set ("img/slinky_small.jpg", AssetType.IMAGE);
		className.set ("img/slinky_tiny.jpg", __ASSET__img_slinky_tiny_jpg);
		type.set ("img/slinky_tiny.jpg", AssetType.IMAGE);
		className.set ("fonts/Oxygen-Bold.ttf", __ASSET__fonts_oxygen_bold_ttf);
		type.set ("fonts/Oxygen-Bold.ttf", AssetType.FONT);
		className.set ("fonts/Oxygen.ttf", __ASSET__fonts_oxygen_ttf);
		type.set ("fonts/Oxygen.ttf", AssetType.FONT);
		className.set ("img/cross-small.png", __ASSET__img_cross_small_png);
		type.set ("img/cross-small.png", AssetType.IMAGE);
		className.set ("img/exclamation.png", __ASSET__img_exclamation_png);
		type.set ("img/exclamation.png", AssetType.IMAGE);
		className.set ("img/icons/binocular--pencil.png", __ASSET__img_icons_binocular__pencil_png);
		type.set ("img/icons/binocular--pencil.png", AssetType.IMAGE);
		className.set ("img/icons/binocular.png", __ASSET__img_icons_binocular_png);
		type.set ("img/icons/binocular.png", AssetType.IMAGE);
		className.set ("img/icons/control.png", __ASSET__img_icons_control_png);
		type.set ("img/icons/control.png", AssetType.IMAGE);
		className.set ("img/icons/disk-black.png", __ASSET__img_icons_disk_black_png);
		type.set ("img/icons/disk-black.png", AssetType.IMAGE);
		className.set ("img/icons/disks-black.png", __ASSET__img_icons_disks_black_png);
		type.set ("img/icons/disks-black.png", AssetType.IMAGE);
		className.set ("img/icons/document-medium.png", __ASSET__img_icons_document_medium_png);
		type.set ("img/icons/document-medium.png", AssetType.IMAGE);
		className.set ("img/icons/document.png", __ASSET__img_icons_document_png);
		type.set ("img/icons/document.png", AssetType.IMAGE);
		className.set ("img/icons/folder-open-document.png", __ASSET__img_icons_folder_open_document_png);
		type.set ("img/icons/folder-open-document.png", AssetType.IMAGE);
		className.set ("img/icons/gear.png", __ASSET__img_icons_gear_png);
		type.set ("img/icons/gear.png", AssetType.IMAGE);
		className.set ("img/icons/wrench-screwdriver.png", __ASSET__img_icons_wrench_screwdriver_png);
		type.set ("img/icons/wrench-screwdriver.png", AssetType.IMAGE);
		className.set ("ui/document.xml", __ASSET__ui_document_xml);
		type.set ("ui/document.xml", AssetType.TEXT);
		className.set ("ui/main.xml", __ASSET__ui_main_xml);
		type.set ("ui/main.xml", AssetType.TEXT);
		className.set ("ui/menus/edit.xml", __ASSET__ui_menus_edit_xml);
		type.set ("ui/menus/edit.xml", AssetType.TEXT);
		className.set ("ui/menus/file.xml", __ASSET__ui_menus_file_xml);
		type.set ("ui/menus/file.xml", AssetType.TEXT);
		className.set ("ui/menus/help.xml", __ASSET__ui_menus_help_xml);
		type.set ("ui/menus/help.xml", AssetType.TEXT);
		className.set ("ui/menus/program.xml", __ASSET__ui_menus_program_xml);
		type.set ("ui/menus/program.xml", AssetType.TEXT);
		className.set ("ui/menus/search.xml", __ASSET__ui_menus_search_xml);
		type.set ("ui/menus/search.xml", AssetType.TEXT);
		className.set ("ui/popups/about.xml", __ASSET__ui_popups_about_xml);
		type.set ("ui/popups/about.xml", AssetType.TEXT);
		className.set ("ui/popups/find-replace.xml", __ASSET__ui_popups_find_replace_xml);
		type.set ("ui/popups/find-replace.xml", AssetType.TEXT);
		className.set ("ui/popups/find.xml", __ASSET__ui_popups_find_xml);
		type.set ("ui/popups/find.xml", AssetType.TEXT);
		className.set ("ui/preferences/main.xml", __ASSET__ui_preferences_main_xml);
		type.set ("ui/preferences/main.xml", AssetType.TEXT);
		className.set ("ui/preferences/prefs-defaults.xml", __ASSET__ui_preferences_prefs_defaults_xml);
		type.set ("ui/preferences/prefs-defaults.xml", AssetType.TEXT);
		className.set ("ui/preferences/prefs-test.xml", __ASSET__ui_preferences_prefs_test_xml);
		type.set ("ui/preferences/prefs-test.xml", AssetType.TEXT);
		className.set ("ui/toolbar.xml", __ASSET__ui_toolbar_xml);
		type.set ("ui/toolbar.xml", AssetType.TEXT);
		className.set ("ui/warnings/flash-only.xml", __ASSET__ui_warnings_flash_only_xml);
		type.set ("ui/warnings/flash-only.xml", AssetType.TEXT);
		className.set ("ui/warnings/not-implemented.xml", __ASSET__ui_warnings_not_implemented_xml);
		type.set ("ui/warnings/not-implemented.xml", AssetType.TEXT);
		
		
		#elseif html5
		
		var id;
		id = "styles/default/circle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/default/collapse.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/default/cross.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/default/expand.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/default/up_down.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/arrow_down.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/arrow_down_dark.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/arrow_down_disabled.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/arrow_left.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/arrow_left_disabled.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/arrow_right.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/arrow_right2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/arrow_right_dark.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/arrow_right_disabled.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/arrow_up.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/arrow_up_disabled.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/circle_dark.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/cross_dark.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/cross_dark_disabled.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/gradient.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/gradient/gradient.min.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/gradient/gradient_mobile.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/gradient/gradient_mobile.min.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/gradient/gripper_horizontal.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/gripper_horizontal_disabled.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/gripper_vertical.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/gradient/gripper_vertical_disabled.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/accordion.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/accordion.min.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/button.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/buttons.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/buttons.min.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/calendar.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/checkbox.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/container.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/glyphs/down_arrow.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/glyphs/hscroll_thumb_gripper_down.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/glyphs/hscroll_thumb_gripper_over.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/glyphs/hscroll_thumb_gripper_up.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/glyphs/left_arrow.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/glyphs/right_arrow.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/glyphs/up_arrow.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/glyphs/vscroll_thumb_gripper_down.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/glyphs/vscroll_thumb_gripper_over.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/glyphs/vscroll_thumb_gripper_up.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/hprogress.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/hscroll.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/listview.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/listview.min.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/listview.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/menus.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/optionbox.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/popup.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/popups.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/rtf.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/scrolls.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/scrolls.min.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/sliders.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/tab.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/tabs.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "styles/windows/textinput.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/vprogress.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/vscroll.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "styles/windows/windows.css";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "img/slinky.jpg";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/slinky_large.jpg";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/slinky_small.jpg";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/slinky_tiny.jpg";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "fonts/Oxygen-Bold.ttf";
		className.set (id, __ASSET__fonts_oxygen_bold_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/Oxygen.ttf";
		className.set (id, __ASSET__fonts_oxygen_ttf);
		
		type.set (id, AssetType.FONT);
		id = "img/cross-small.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/exclamation.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/icons/binocular--pencil.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/icons/binocular.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/icons/control.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/icons/disk-black.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/icons/disks-black.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/icons/document-medium.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/icons/document.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/icons/folder-open-document.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/icons/gear.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/icons/wrench-screwdriver.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "ui/document.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/main.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/menus/edit.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/menus/file.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/menus/help.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/menus/program.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/menus/search.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/popups/about.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/popups/find-replace.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/popups/find.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/preferences/main.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/preferences/prefs-defaults.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/preferences/prefs-test.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/toolbar.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/warnings/flash-only.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "ui/warnings/not-implemented.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		
		
		#else
		
		#if (windows || mac || linux)
		
		/*var useManifest = false;
		
		className.set ("styles/default/circle.png", __ASSET__styles_default_circle_png);
		type.set ("styles/default/circle.png", AssetType.IMAGE);
		
		className.set ("styles/default/collapse.png", __ASSET__styles_default_collapse_png);
		type.set ("styles/default/collapse.png", AssetType.IMAGE);
		
		className.set ("styles/default/cross.png", __ASSET__styles_default_cross_png);
		type.set ("styles/default/cross.png", AssetType.IMAGE);
		
		className.set ("styles/default/expand.png", __ASSET__styles_default_expand_png);
		type.set ("styles/default/expand.png", AssetType.IMAGE);
		
		className.set ("styles/default/up_down.png", __ASSET__styles_default_up_down_png);
		type.set ("styles/default/up_down.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/arrow_down.png", __ASSET__styles_gradient_arrow_down_png);
		type.set ("styles/gradient/arrow_down.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/arrow_down_dark.png", __ASSET__styles_gradient_arrow_down_dark_png);
		type.set ("styles/gradient/arrow_down_dark.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/arrow_down_disabled.png", __ASSET__styles_gradient_arrow_down_disabled_png);
		type.set ("styles/gradient/arrow_down_disabled.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/arrow_left.png", __ASSET__styles_gradient_arrow_left_png);
		type.set ("styles/gradient/arrow_left.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/arrow_left_disabled.png", __ASSET__styles_gradient_arrow_left_disabled_png);
		type.set ("styles/gradient/arrow_left_disabled.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/arrow_right.png", __ASSET__styles_gradient_arrow_right_png);
		type.set ("styles/gradient/arrow_right.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/arrow_right2.png", __ASSET__styles_gradient_arrow_right2_png);
		type.set ("styles/gradient/arrow_right2.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/arrow_right_dark.png", __ASSET__styles_gradient_arrow_right_dark_png);
		type.set ("styles/gradient/arrow_right_dark.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/arrow_right_disabled.png", __ASSET__styles_gradient_arrow_right_disabled_png);
		type.set ("styles/gradient/arrow_right_disabled.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/arrow_up.png", __ASSET__styles_gradient_arrow_up_png);
		type.set ("styles/gradient/arrow_up.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/arrow_up_disabled.png", __ASSET__styles_gradient_arrow_up_disabled_png);
		type.set ("styles/gradient/arrow_up_disabled.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/circle_dark.png", __ASSET__styles_gradient_circle_dark_png);
		type.set ("styles/gradient/circle_dark.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/cross_dark.png", __ASSET__styles_gradient_cross_dark_png);
		type.set ("styles/gradient/cross_dark.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/cross_dark_disabled.png", __ASSET__styles_gradient_cross_dark_disabled_png);
		type.set ("styles/gradient/cross_dark_disabled.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/gradient.css", __ASSET__styles_gradient_gradient_css);
		type.set ("styles/gradient/gradient.css", AssetType.TEXT);
		
		className.set ("styles/gradient/gradient.min.css", __ASSET__styles_gradient_gradient_min_css);
		type.set ("styles/gradient/gradient.min.css", AssetType.TEXT);
		
		className.set ("styles/gradient/gradient_mobile.css", __ASSET__styles_gradient_gradient_mobile_css);
		type.set ("styles/gradient/gradient_mobile.css", AssetType.TEXT);
		
		className.set ("styles/gradient/gradient_mobile.min.css", __ASSET__styles_gradient_gradient_mobile_min_css);
		type.set ("styles/gradient/gradient_mobile.min.css", AssetType.TEXT);
		
		className.set ("styles/gradient/gripper_horizontal.png", __ASSET__styles_gradient_gripper_horizontal_png);
		type.set ("styles/gradient/gripper_horizontal.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/gripper_horizontal_disabled.png", __ASSET__styles_gradient_gripper_horizontal_disabled_png);
		type.set ("styles/gradient/gripper_horizontal_disabled.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/gripper_vertical.png", __ASSET__styles_gradient_gripper_vertical_png);
		type.set ("styles/gradient/gripper_vertical.png", AssetType.IMAGE);
		
		className.set ("styles/gradient/gripper_vertical_disabled.png", __ASSET__styles_gradient_gripper_vertical_disabled_png);
		type.set ("styles/gradient/gripper_vertical_disabled.png", AssetType.IMAGE);
		
		className.set ("styles/windows/accordion.css", __ASSET__styles_windows_accordion_css);
		type.set ("styles/windows/accordion.css", AssetType.TEXT);
		
		className.set ("styles/windows/accordion.min.css", __ASSET__styles_windows_accordion_min_css);
		type.set ("styles/windows/accordion.min.css", AssetType.TEXT);
		
		className.set ("styles/windows/button.png", __ASSET__styles_windows_button_png);
		type.set ("styles/windows/button.png", AssetType.IMAGE);
		
		className.set ("styles/windows/buttons.css", __ASSET__styles_windows_buttons_css);
		type.set ("styles/windows/buttons.css", AssetType.TEXT);
		
		className.set ("styles/windows/buttons.min.css", __ASSET__styles_windows_buttons_min_css);
		type.set ("styles/windows/buttons.min.css", AssetType.TEXT);
		
		className.set ("styles/windows/calendar.css", __ASSET__styles_windows_calendar_css);
		type.set ("styles/windows/calendar.css", AssetType.TEXT);
		
		className.set ("styles/windows/checkbox.png", __ASSET__styles_windows_checkbox_png);
		type.set ("styles/windows/checkbox.png", AssetType.IMAGE);
		
		className.set ("styles/windows/container.png", __ASSET__styles_windows_container_png);
		type.set ("styles/windows/container.png", AssetType.IMAGE);
		
		className.set ("styles/windows/glyphs/down_arrow.png", __ASSET__styles_windows_glyphs_down_arrow_png);
		type.set ("styles/windows/glyphs/down_arrow.png", AssetType.IMAGE);
		
		className.set ("styles/windows/glyphs/hscroll_thumb_gripper_down.png", __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_down_png);
		type.set ("styles/windows/glyphs/hscroll_thumb_gripper_down.png", AssetType.IMAGE);
		
		className.set ("styles/windows/glyphs/hscroll_thumb_gripper_over.png", __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_over_png);
		type.set ("styles/windows/glyphs/hscroll_thumb_gripper_over.png", AssetType.IMAGE);
		
		className.set ("styles/windows/glyphs/hscroll_thumb_gripper_up.png", __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_up_png);
		type.set ("styles/windows/glyphs/hscroll_thumb_gripper_up.png", AssetType.IMAGE);
		
		className.set ("styles/windows/glyphs/left_arrow.png", __ASSET__styles_windows_glyphs_left_arrow_png);
		type.set ("styles/windows/glyphs/left_arrow.png", AssetType.IMAGE);
		
		className.set ("styles/windows/glyphs/right_arrow.png", __ASSET__styles_windows_glyphs_right_arrow_png);
		type.set ("styles/windows/glyphs/right_arrow.png", AssetType.IMAGE);
		
		className.set ("styles/windows/glyphs/up_arrow.png", __ASSET__styles_windows_glyphs_up_arrow_png);
		type.set ("styles/windows/glyphs/up_arrow.png", AssetType.IMAGE);
		
		className.set ("styles/windows/glyphs/vscroll_thumb_gripper_down.png", __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_down_png);
		type.set ("styles/windows/glyphs/vscroll_thumb_gripper_down.png", AssetType.IMAGE);
		
		className.set ("styles/windows/glyphs/vscroll_thumb_gripper_over.png", __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_over_png);
		type.set ("styles/windows/glyphs/vscroll_thumb_gripper_over.png", AssetType.IMAGE);
		
		className.set ("styles/windows/glyphs/vscroll_thumb_gripper_up.png", __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_up_png);
		type.set ("styles/windows/glyphs/vscroll_thumb_gripper_up.png", AssetType.IMAGE);
		
		className.set ("styles/windows/hprogress.png", __ASSET__styles_windows_hprogress_png);
		type.set ("styles/windows/hprogress.png", AssetType.IMAGE);
		
		className.set ("styles/windows/hscroll.png", __ASSET__styles_windows_hscroll_png);
		type.set ("styles/windows/hscroll.png", AssetType.IMAGE);
		
		className.set ("styles/windows/listview.css", __ASSET__styles_windows_listview_css);
		type.set ("styles/windows/listview.css", AssetType.TEXT);
		
		className.set ("styles/windows/listview.min.css", __ASSET__styles_windows_listview_min_css);
		type.set ("styles/windows/listview.min.css", AssetType.TEXT);
		
		className.set ("styles/windows/listview.png", __ASSET__styles_windows_listview_png);
		type.set ("styles/windows/listview.png", AssetType.IMAGE);
		
		className.set ("styles/windows/menus.css", __ASSET__styles_windows_menus_css);
		type.set ("styles/windows/menus.css", AssetType.TEXT);
		
		className.set ("styles/windows/optionbox.png", __ASSET__styles_windows_optionbox_png);
		type.set ("styles/windows/optionbox.png", AssetType.IMAGE);
		
		className.set ("styles/windows/popup.png", __ASSET__styles_windows_popup_png);
		type.set ("styles/windows/popup.png", AssetType.IMAGE);
		
		className.set ("styles/windows/popups.css", __ASSET__styles_windows_popups_css);
		type.set ("styles/windows/popups.css", AssetType.TEXT);
		
		className.set ("styles/windows/rtf.css", __ASSET__styles_windows_rtf_css);
		type.set ("styles/windows/rtf.css", AssetType.TEXT);
		
		className.set ("styles/windows/scrolls.css", __ASSET__styles_windows_scrolls_css);
		type.set ("styles/windows/scrolls.css", AssetType.TEXT);
		
		className.set ("styles/windows/scrolls.min.css", __ASSET__styles_windows_scrolls_min_css);
		type.set ("styles/windows/scrolls.min.css", AssetType.TEXT);
		
		className.set ("styles/windows/sliders.css", __ASSET__styles_windows_sliders_css);
		type.set ("styles/windows/sliders.css", AssetType.TEXT);
		
		className.set ("styles/windows/tab.png", __ASSET__styles_windows_tab_png);
		type.set ("styles/windows/tab.png", AssetType.IMAGE);
		
		className.set ("styles/windows/tabs.css", __ASSET__styles_windows_tabs_css);
		type.set ("styles/windows/tabs.css", AssetType.TEXT);
		
		className.set ("styles/windows/textinput.png", __ASSET__styles_windows_textinput_png);
		type.set ("styles/windows/textinput.png", AssetType.IMAGE);
		
		className.set ("styles/windows/vprogress.png", __ASSET__styles_windows_vprogress_png);
		type.set ("styles/windows/vprogress.png", AssetType.IMAGE);
		
		className.set ("styles/windows/vscroll.png", __ASSET__styles_windows_vscroll_png);
		type.set ("styles/windows/vscroll.png", AssetType.IMAGE);
		
		className.set ("styles/windows/windows.css", __ASSET__styles_windows_windows_css);
		type.set ("styles/windows/windows.css", AssetType.TEXT);
		
		className.set ("img/slinky.jpg", __ASSET__img_slinky_jpg);
		type.set ("img/slinky.jpg", AssetType.IMAGE);
		
		className.set ("img/slinky_large.jpg", __ASSET__img_slinky_large_jpg);
		type.set ("img/slinky_large.jpg", AssetType.IMAGE);
		
		className.set ("img/slinky_small.jpg", __ASSET__img_slinky_small_jpg);
		type.set ("img/slinky_small.jpg", AssetType.IMAGE);
		
		className.set ("img/slinky_tiny.jpg", __ASSET__img_slinky_tiny_jpg);
		type.set ("img/slinky_tiny.jpg", AssetType.IMAGE);
		
		className.set ("fonts/Oxygen-Bold.ttf", __ASSET__fonts_oxygen_bold_ttf);
		type.set ("fonts/Oxygen-Bold.ttf", AssetType.FONT);
		
		className.set ("fonts/Oxygen.ttf", __ASSET__fonts_oxygen_ttf);
		type.set ("fonts/Oxygen.ttf", AssetType.FONT);
		
		className.set ("img/cross-small.png", __ASSET__img_cross_small_png);
		type.set ("img/cross-small.png", AssetType.IMAGE);
		
		className.set ("img/exclamation.png", __ASSET__img_exclamation_png);
		type.set ("img/exclamation.png", AssetType.IMAGE);
		
		className.set ("img/icons/binocular--pencil.png", __ASSET__img_icons_binocular__pencil_png);
		type.set ("img/icons/binocular--pencil.png", AssetType.IMAGE);
		
		className.set ("img/icons/binocular.png", __ASSET__img_icons_binocular_png);
		type.set ("img/icons/binocular.png", AssetType.IMAGE);
		
		className.set ("img/icons/control.png", __ASSET__img_icons_control_png);
		type.set ("img/icons/control.png", AssetType.IMAGE);
		
		className.set ("img/icons/disk-black.png", __ASSET__img_icons_disk_black_png);
		type.set ("img/icons/disk-black.png", AssetType.IMAGE);
		
		className.set ("img/icons/disks-black.png", __ASSET__img_icons_disks_black_png);
		type.set ("img/icons/disks-black.png", AssetType.IMAGE);
		
		className.set ("img/icons/document-medium.png", __ASSET__img_icons_document_medium_png);
		type.set ("img/icons/document-medium.png", AssetType.IMAGE);
		
		className.set ("img/icons/document.png", __ASSET__img_icons_document_png);
		type.set ("img/icons/document.png", AssetType.IMAGE);
		
		className.set ("img/icons/folder-open-document.png", __ASSET__img_icons_folder_open_document_png);
		type.set ("img/icons/folder-open-document.png", AssetType.IMAGE);
		
		className.set ("img/icons/gear.png", __ASSET__img_icons_gear_png);
		type.set ("img/icons/gear.png", AssetType.IMAGE);
		
		className.set ("img/icons/wrench-screwdriver.png", __ASSET__img_icons_wrench_screwdriver_png);
		type.set ("img/icons/wrench-screwdriver.png", AssetType.IMAGE);
		
		className.set ("ui/document.xml", __ASSET__ui_document_xml);
		type.set ("ui/document.xml", AssetType.TEXT);
		
		className.set ("ui/main.xml", __ASSET__ui_main_xml);
		type.set ("ui/main.xml", AssetType.TEXT);
		
		className.set ("ui/menus/edit.xml", __ASSET__ui_menus_edit_xml);
		type.set ("ui/menus/edit.xml", AssetType.TEXT);
		
		className.set ("ui/menus/file.xml", __ASSET__ui_menus_file_xml);
		type.set ("ui/menus/file.xml", AssetType.TEXT);
		
		className.set ("ui/menus/help.xml", __ASSET__ui_menus_help_xml);
		type.set ("ui/menus/help.xml", AssetType.TEXT);
		
		className.set ("ui/menus/program.xml", __ASSET__ui_menus_program_xml);
		type.set ("ui/menus/program.xml", AssetType.TEXT);
		
		className.set ("ui/menus/search.xml", __ASSET__ui_menus_search_xml);
		type.set ("ui/menus/search.xml", AssetType.TEXT);
		
		className.set ("ui/popups/about.xml", __ASSET__ui_popups_about_xml);
		type.set ("ui/popups/about.xml", AssetType.TEXT);
		
		className.set ("ui/popups/find-replace.xml", __ASSET__ui_popups_find_replace_xml);
		type.set ("ui/popups/find-replace.xml", AssetType.TEXT);
		
		className.set ("ui/popups/find.xml", __ASSET__ui_popups_find_xml);
		type.set ("ui/popups/find.xml", AssetType.TEXT);
		
		className.set ("ui/preferences/main.xml", __ASSET__ui_preferences_main_xml);
		type.set ("ui/preferences/main.xml", AssetType.TEXT);
		
		className.set ("ui/preferences/prefs-defaults.xml", __ASSET__ui_preferences_prefs_defaults_xml);
		type.set ("ui/preferences/prefs-defaults.xml", AssetType.TEXT);
		
		className.set ("ui/preferences/prefs-test.xml", __ASSET__ui_preferences_prefs_test_xml);
		type.set ("ui/preferences/prefs-test.xml", AssetType.TEXT);
		
		className.set ("ui/toolbar.xml", __ASSET__ui_toolbar_xml);
		type.set ("ui/toolbar.xml", AssetType.TEXT);
		
		className.set ("ui/warnings/flash-only.xml", __ASSET__ui_warnings_flash_only_xml);
		type.set ("ui/warnings/flash-only.xml", AssetType.TEXT);
		
		className.set ("ui/warnings/not-implemented.xml", __ASSET__ui_warnings_not_implemented_xml);
		type.set ("ui/warnings/not-implemented.xml", AssetType.TEXT);
		*/
		var useManifest = true;
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && requestedType == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif js
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return AudioBuffer.fromFile (path.get (id));
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif js
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		//return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		//else 
		return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Dynamic /*Font*/ {
		
		// TODO: Complete Lime Font API
		
		#if openfl
		#if (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), openfl.text.Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			openfl.text.Font.registerFont (fontClass);
			return cast (Type.createInstance (fontClass, []), openfl.text.Font);
			
		} else {
			
			return new openfl.text.Font (path.get (id));
			
		}
		
		#end
		#end
		
		return null;
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif js
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		return Image.fromFile (path.get (id));
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif js
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getAudioBuffer (id));
			
		//}
		
		#else
		
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if js
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__styles_default_circle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_default_collapse_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_default_cross_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_default_expand_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_default_up_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_arrow_down_dark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_arrow_down_disabled_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_arrow_left_disabled_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_arrow_right2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_arrow_right_dark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_arrow_right_disabled_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_arrow_up_disabled_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_circle_dark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_cross_dark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_cross_dark_disabled_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_gradient_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_gradient_min_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_gradient_mobile_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_gradient_mobile_min_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_gripper_horizontal_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_gripper_horizontal_disabled_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_gripper_vertical_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_gradient_gripper_vertical_disabled_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_accordion_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_accordion_min_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_buttons_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_buttons_min_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_calendar_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_checkbox_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_container_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_glyphs_down_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_over_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_glyphs_left_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_glyphs_right_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_glyphs_up_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_over_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_hprogress_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_hscroll_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_listview_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_listview_min_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_listview_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_menus_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_optionbox_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_popup_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_popups_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_rtf_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_scrolls_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_scrolls_min_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_sliders_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_tabs_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__styles_windows_textinput_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_vprogress_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_vscroll_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__styles_windows_windows_css extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__img_slinky_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_slinky_large_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_slinky_small_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_slinky_tiny_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__fonts_oxygen_bold_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__fonts_oxygen_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__img_cross_small_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_exclamation_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_icons_binocular__pencil_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_icons_binocular_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_icons_control_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_icons_disk_black_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_icons_disks_black_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_icons_document_medium_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_icons_document_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_icons_folder_open_document_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_icons_gear_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_icons_wrench_screwdriver_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__ui_document_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_main_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_menus_edit_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_menus_file_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_menus_help_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_menus_program_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_menus_search_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_popups_about_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_popups_find_replace_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_popups_find_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_preferences_main_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_preferences_prefs_defaults_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_preferences_prefs_test_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_toolbar_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_warnings_flash_only_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__ui_warnings_not_implemented_xml extends flash.utils.ByteArray { }


#elseif html5

#if openfl




































































@:keep #if display private #end class __ASSET__fonts_oxygen_bold_ttf extends openfl.text.Font { public function new () { super (); fontName = "fonts/Oxygen-Bold.ttf"; } } 
@:keep #if display private #end class __ASSET__fonts_oxygen_ttf extends openfl.text.Font { public function new () { super (); fontName = "fonts/Oxygen.ttf"; } } 





























#end

#elseif (windows || mac || linux)


//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/default/circle.png") class __ASSET__styles_default_circle_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/default/collapse.png") class __ASSET__styles_default_collapse_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/default/cross.png") class __ASSET__styles_default_cross_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/default/expand.png") class __ASSET__styles_default_expand_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/default/up_down.png") class __ASSET__styles_default_up_down_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/arrow_down.png") class __ASSET__styles_gradient_arrow_down_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/arrow_down_dark.png") class __ASSET__styles_gradient_arrow_down_dark_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/arrow_down_disabled.png") class __ASSET__styles_gradient_arrow_down_disabled_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/arrow_left.png") class __ASSET__styles_gradient_arrow_left_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/arrow_left_disabled.png") class __ASSET__styles_gradient_arrow_left_disabled_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/arrow_right.png") class __ASSET__styles_gradient_arrow_right_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/arrow_right2.png") class __ASSET__styles_gradient_arrow_right2_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/arrow_right_dark.png") class __ASSET__styles_gradient_arrow_right_dark_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/arrow_right_disabled.png") class __ASSET__styles_gradient_arrow_right_disabled_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/arrow_up.png") class __ASSET__styles_gradient_arrow_up_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/arrow_up_disabled.png") class __ASSET__styles_gradient_arrow_up_disabled_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/circle_dark.png") class __ASSET__styles_gradient_circle_dark_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/cross_dark.png") class __ASSET__styles_gradient_cross_dark_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/cross_dark_disabled.png") class __ASSET__styles_gradient_cross_dark_disabled_png extends openfl.display.BitmapData {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/gradient.css") class __ASSET__styles_gradient_gradient_css extends lime.utils.ByteArray {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/gradient.min.css") class __ASSET__styles_gradient_gradient_min_css extends lime.utils.ByteArray {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/gradient_mobile.css") class __ASSET__styles_gradient_gradient_mobile_css extends lime.utils.ByteArray {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/gradient_mobile.min.css") class __ASSET__styles_gradient_gradient_mobile_min_css extends lime.utils.ByteArray {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/gripper_horizontal.png") class __ASSET__styles_gradient_gripper_horizontal_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/gripper_horizontal_disabled.png") class __ASSET__styles_gradient_gripper_horizontal_disabled_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/gripper_vertical.png") class __ASSET__styles_gradient_gripper_vertical_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/gradient/gripper_vertical_disabled.png") class __ASSET__styles_gradient_gripper_vertical_disabled_png extends openfl.display.BitmapData {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/accordion.css") class __ASSET__styles_windows_accordion_css extends lime.utils.ByteArray {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/accordion.min.css") class __ASSET__styles_windows_accordion_min_css extends lime.utils.ByteArray {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/button.png") class __ASSET__styles_windows_button_png extends openfl.display.BitmapData {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/buttons.css") class __ASSET__styles_windows_buttons_css extends lime.utils.ByteArray {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/buttons.min.css") class __ASSET__styles_windows_buttons_min_css extends lime.utils.ByteArray {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/calendar.css") class __ASSET__styles_windows_calendar_css extends lime.utils.ByteArray {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/checkbox.png") class __ASSET__styles_windows_checkbox_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/container.png") class __ASSET__styles_windows_container_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/glyphs/down_arrow.png") class __ASSET__styles_windows_glyphs_down_arrow_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/glyphs/hscroll_thumb_gripper_down.png") class __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_down_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/glyphs/hscroll_thumb_gripper_over.png") class __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_over_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/glyphs/hscroll_thumb_gripper_up.png") class __ASSET__styles_windows_glyphs_hscroll_thumb_gripper_up_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/glyphs/left_arrow.png") class __ASSET__styles_windows_glyphs_left_arrow_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/glyphs/right_arrow.png") class __ASSET__styles_windows_glyphs_right_arrow_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/glyphs/up_arrow.png") class __ASSET__styles_windows_glyphs_up_arrow_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/glyphs/vscroll_thumb_gripper_down.png") class __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_down_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/glyphs/vscroll_thumb_gripper_over.png") class __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_over_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/glyphs/vscroll_thumb_gripper_up.png") class __ASSET__styles_windows_glyphs_vscroll_thumb_gripper_up_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/hprogress.png") class __ASSET__styles_windows_hprogress_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/hscroll.png") class __ASSET__styles_windows_hscroll_png extends openfl.display.BitmapData {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/listview.css") class __ASSET__styles_windows_listview_css extends lime.utils.ByteArray {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/listview.min.css") class __ASSET__styles_windows_listview_min_css extends lime.utils.ByteArray {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/listview.png") class __ASSET__styles_windows_listview_png extends openfl.display.BitmapData {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/menus.css") class __ASSET__styles_windows_menus_css extends lime.utils.ByteArray {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/optionbox.png") class __ASSET__styles_windows_optionbox_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/popup.png") class __ASSET__styles_windows_popup_png extends openfl.display.BitmapData {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/popups.css") class __ASSET__styles_windows_popups_css extends lime.utils.ByteArray {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/rtf.css") class __ASSET__styles_windows_rtf_css extends lime.utils.ByteArray {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/scrolls.css") class __ASSET__styles_windows_scrolls_css extends lime.utils.ByteArray {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/scrolls.min.css") class __ASSET__styles_windows_scrolls_min_css extends lime.utils.ByteArray {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/sliders.css") class __ASSET__styles_windows_sliders_css extends lime.utils.ByteArray {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/tab.png") class __ASSET__styles_windows_tab_png extends openfl.display.BitmapData {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/tabs.css") class __ASSET__styles_windows_tabs_css extends lime.utils.ByteArray {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/textinput.png") class __ASSET__styles_windows_textinput_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/vprogress.png") class __ASSET__styles_windows_vprogress_png extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/vscroll.png") class __ASSET__styles_windows_vscroll_png extends openfl.display.BitmapData {}
//@:file("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/styles/windows/windows.css") class __ASSET__styles_windows_windows_css extends lime.utils.ByteArray {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/img/slinky.jpg") class __ASSET__img_slinky_jpg extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/img/slinky_large.jpg") class __ASSET__img_slinky_large_jpg extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/img/slinky_small.jpg") class __ASSET__img_slinky_small_jpg extends openfl.display.BitmapData {}
//@:bitmap("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/img/slinky_tiny.jpg") class __ASSET__img_slinky_tiny_jpg extends openfl.display.BitmapData {}
//@:font("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/fonts/Oxygen-Bold.ttf") class __ASSET__fonts_oxygen_bold_ttf extends openfl.text.Font {}
//@:font("C:/HaxeToolkit/haxe/lib/haxeui/1,5,12/fonts/Oxygen.ttf") class __ASSET__fonts_oxygen_ttf extends openfl.text.Font {}
//@:bitmap("assets/img/cross-small.png") class __ASSET__img_cross_small_png extends openfl.display.BitmapData {}
//@:bitmap("assets/img/exclamation.png") class __ASSET__img_exclamation_png extends openfl.display.BitmapData {}
//@:bitmap("assets/img/icons/binocular--pencil.png") class __ASSET__img_icons_binocular__pencil_png extends openfl.display.BitmapData {}
//@:bitmap("assets/img/icons/binocular.png") class __ASSET__img_icons_binocular_png extends openfl.display.BitmapData {}
//@:bitmap("assets/img/icons/control.png") class __ASSET__img_icons_control_png extends openfl.display.BitmapData {}
//@:bitmap("assets/img/icons/disk-black.png") class __ASSET__img_icons_disk_black_png extends openfl.display.BitmapData {}
//@:bitmap("assets/img/icons/disks-black.png") class __ASSET__img_icons_disks_black_png extends openfl.display.BitmapData {}
//@:bitmap("assets/img/icons/document-medium.png") class __ASSET__img_icons_document_medium_png extends openfl.display.BitmapData {}
//@:bitmap("assets/img/icons/document.png") class __ASSET__img_icons_document_png extends openfl.display.BitmapData {}
//@:bitmap("assets/img/icons/folder-open-document.png") class __ASSET__img_icons_folder_open_document_png extends openfl.display.BitmapData {}
//@:bitmap("assets/img/icons/gear.png") class __ASSET__img_icons_gear_png extends openfl.display.BitmapData {}
//@:bitmap("assets/img/icons/wrench-screwdriver.png") class __ASSET__img_icons_wrench_screwdriver_png extends openfl.display.BitmapData {}
//@:file("assets/ui/document.xml") class __ASSET__ui_document_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/main.xml") class __ASSET__ui_main_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/menus/edit.xml") class __ASSET__ui_menus_edit_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/menus/file.xml") class __ASSET__ui_menus_file_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/menus/help.xml") class __ASSET__ui_menus_help_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/menus/program.xml") class __ASSET__ui_menus_program_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/menus/search.xml") class __ASSET__ui_menus_search_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/popups/about.xml") class __ASSET__ui_popups_about_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/popups/find-replace.xml") class __ASSET__ui_popups_find_replace_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/popups/find.xml") class __ASSET__ui_popups_find_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/preferences/main.xml") class __ASSET__ui_preferences_main_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/preferences/prefs-defaults.xml") class __ASSET__ui_preferences_prefs_defaults_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/preferences/prefs-test.xml") class __ASSET__ui_preferences_prefs_test_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/toolbar.xml") class __ASSET__ui_toolbar_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/warnings/flash-only.xml") class __ASSET__ui_warnings_flash_only_xml extends lime.utils.ByteArray {}
//@:file("assets/ui/warnings/not-implemented.xml") class __ASSET__ui_warnings_not_implemented_xml extends lime.utils.ByteArray {}
//


#end
#end

