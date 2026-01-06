local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 設定ファイルの自動リロード
config.automatically_reload_config = true

-- フォント
config.font_size = 14.0
config.font = wezterm.font("HackGen35 Console NF")

-- カラースキーム
config.color_scheme = "kanagawabones"
-- カラースキームを取得
local scheme = wezterm.color.get_builtin_schemes()["kanagawabones"]

-- 背景設定
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.window_background_gradient = {
  colors = { scheme.background },
}

----------------------------------------------------
-- カーソル
----------------------------------------------------
-- スタイル
config.default_cursor_style = 'BlinkingBar'
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 500
-- ビジュアルベル（カーソルが少し明るくなる）
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = 'CursorColor',
}

----------------------------------------------------
-- ウィンドウ
----------------------------------------------------
-- タイトルバーの削除
config.window_decorations = "RESIZE"

-- ウィンドウの枠線を追加
config.window_frame = {
  border_left_width = '1px',
	border_right_width = '1px',
	border_bottom_height = '1px',
	border_top_height = '1px',
	border_left_color = '#484848',
	border_right_color = '#484848',
	border_bottom_color = '#484848',
	border_top_color = '#484848',
}

-- ウィンドウサイズ
config.initial_rows = 40 -- 高さ（行数）
config.initial_cols = 100 -- 幅（列数）

----------------------------------------------------
-- タブ
----------------------------------------------------
-- タブバーの装飾を無効化
config.use_fancy_tab_bar = false

-- タブバーの+を非表示
config.show_new_tab_button_in_tab_bar = false

-- タブバーの背景色
config.colors = {
  tab_bar = {
    background = scheme.background,
  },
}

-- タブの形をカスタマイズ
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  -- パネルがズームされている時はアイコンを変更
  local HEADER = tab.active_pane.is_zoomed and wezterm.nerdfonts.md_arrow_expand or wezterm.nerdfonts.oct_terminal
	local background = scheme.background
	local foreground = scheme.foreground
	if tab.is_active then
		background = "#C34043"
		foreground = scheme.foreground
	end
  -- タブのタイトル
	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. " "
  -- タブの装飾
	return {
    { Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = wezterm.nerdfonts.indent_line },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
    { Text = HEADER },
    { Text = "  " },
    { Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = wezterm.nerdfonts.indent_line },
	}
end)

----------------------------------------------------
-- ステータスバー
----------------------------------------------------
local function AddIcon(elems, background, text)
  table.insert(elems, { Foreground = { Color = scheme.background } })
  table.insert(elems, { Background = { Color = background } })
  table.insert(elems, { Text = " " .. text .. " " })
end

wezterm.on('update-status', function(window, pane)
  config.status_update_interval = 1000
  local elems = {}
  local active_key_table = window:active_key_table()

  if window:leader_is_active() then
    AddIcon(elems, scheme.foreground, wezterm.nerdfonts.cod_symbol_event)
  elseif active_key_table == "resize_pane" then
    AddIcon(elems, "#e5c283", wezterm.nerdfonts.md_ruler_square)
  elseif active_key_table == "copy_mode" then
    AddIcon(elems, "#98BB6C", wezterm.nerdfonts.md_content_copy)
  else
    AddIcon(elems, scheme.background, ' ')
  end

  window:set_left_status(wezterm.format(elems))
end)

----------------------------------------------------
-- その他
----------------------------------------------------
-- ベル音無効化
config.audible_bell = "Disabled"

-- フォーカス時に英字入力に切り替え
wezterm.on("window-focus-changed", function(window, pane)
  os.execute("/opt/homebrew/bin/im-select com.apple.keylayout.ABC")
end)

----------------------------------------------------
-- キーバインド
----------------------------------------------------
-- デフォルトのキーバインドを無効化
config.disable_default_key_bindings = true
-- キーバインド設定の読み込み
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
-- リーダーキー設定
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

return config