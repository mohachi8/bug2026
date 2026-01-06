local wezterm = require 'wezterm'
local act = wezterm.action

return {
  keys = {
    ----------------------------------------------------
    -- 基本操作
    ----------------------------------------------------
    -- クリップボードにコピー
    { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
    -- クリップボードから貼り付け
    { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
    -- ウィンドウを非表示
    { key = 'm', mods = 'SUPER', action = act.Hide },    
    -- アプリケーションを非表示
    { key = 'h', mods = 'SUPER', action = act.HideApplication },
    -- アプリケーションを終了
    { key = 'q', mods = 'SUPER', action = act.QuitApplication },
    -- 新しいウィンドウを開く
    { key = 'n', mods = 'SUPER', action = act.SpawnWindow },
    -- 検索
    { key = 'f', mods = 'SUPER', action = act.Search 'CurrentSelectionOrEmptyString' },
    -- フォントサイズ変更
    { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
    { key = '0', mods = 'SUPER', action = act.ResetFontSize },
    
    ----------------------------------------------------
    -- タブ操作
    ----------------------------------------------------
    -- タブを左に移動
    { key = '[', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(-1) },
    { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    -- タブを右に移動
    { key = ']', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    -- タブ切替 Cmd + 数字
    { key = "1", mods = "SUPER", action = act.ActivateTab(0) },
    { key = "2", mods = "SUPER", action = act.ActivateTab(1) },
    { key = "3", mods = "SUPER", action = act.ActivateTab(2) },
    { key = "4", mods = "SUPER", action = act.ActivateTab(3) },
    { key = "5", mods = "SUPER", action = act.ActivateTab(4) },
    { key = "6", mods = "SUPER", action = act.ActivateTab(5) },
    { key = "7", mods = "SUPER", action = act.ActivateTab(6) },
    { key = "8", mods = "SUPER", action = act.ActivateTab(7) },
    { key = "9", mods = "SUPER", action = act.ActivateTab(-1) },
    -- 新しいタブを開く
    { key = 't', mods = 'SUPER', action = act.SpawnTab 'CurrentPaneDomain' },

    ----------------------------------------------------
    -- ペイン操作
    ----------------------------------------------------
    -- 縦分割
    { key = 'd', mods = 'CMD', action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    -- 横分割
    { key = 'd', mods = 'CMD|SHIFT', action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    -- ペイン移動
    { key = "h", mods = 'LEADER', action = act.ActivatePaneDirection("Left") },
    { key = "l", mods = 'LEADER', action = act.ActivatePaneDirection("Right") },
    { key = "k", mods = 'LEADER', action = act.ActivatePaneDirection("Up") },
    { key = "j", mods = 'LEADER', action = act.ActivatePaneDirection("Down") },
    -- ペインのズーム切り替え
    { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
    -- ペインを閉じる
    { key = 'w', mods = 'SUPER', action = act.CloseCurrentPane{ confirm = true } },
    
    ------------------------------------------------------
    -- モード操作
    ----------------------------------------------------
    -- Paneサイズ調整モードに入る
    { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
    -- copy modeに入る
    { key = 'c', mods = 'LEADER', action = act.ActivateCopyMode },
    -- 絵文字入力モードに入る
    { key = 'e', mods = 'LEADER', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    
    ----------------------------------------------------
    -- その他
    ----------------------------------------------------
    -- フルスクリーン切り替え
    { key = 'Enter', mods = 'LEADER', action = act.ToggleFullScreen },
    -- 設定をリロード
    { key = 'r', mods = 'SUPER', action = act.ReloadConfiguration },
    -- クイック選択
    { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.QuickSelect },
    -- スクロールバックをクリア
    { key = 'k', mods = 'SUPER', action = act.ClearScrollback 'ScrollbackOnly' },
    -- デバッグオーバーレイを表示
    { key = 'l', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
    -- コマンドパレットを開く
    { key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
  },
  
  key_tables = {
    -- Paneサイズ調整
    resize_pane = {
      { key = "h", mods = 'NONE', action = act.AdjustPaneSize({ "Left", 1 }) },
      { key = "l", mods = 'NONE', action = act.AdjustPaneSize({ "Right", 1 }) },
      { key = "k", mods = 'NONE', action = act.AdjustPaneSize({ "Up", 1 }) },
      { key = "j", mods = 'NONE', action = act.AdjustPaneSize({ "Down", 1 }) },
      -- モード終了
      { key = "Enter", mods = 'NONE', action = "PopKeyTable" },
      { key = "Escape", mods = 'NONE', action = "PopKeyTable" },
      { key = "q", mods = 'NONE', action = "PopKeyTable" },
    },

    -- copy mode(Vim)
    copy_mode = {
      -- カーソル移動
      { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      
      -- 行頭/行末に移動
      { key = '^', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },

      -- 左端に移動
      { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },

      -- 選択範囲の移動
      { key = 'o', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd' },
      { key = 'O', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      
      -- 単語移動
      { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },

      -- ジャンプ
      { key = 't', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = true } } },
      { key = 'f', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = false } } },
      { key = 'T', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
      { key = 'F', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
      
      -- 一番上/一番下に移動
      { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
      { key = 'G', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackBottom' },
      
      -- ビューポートの移動
      { key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
      { key = 'L', mods = 'NONE', action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'M', mods = 'NONE', action = act.CopyMode 'MoveToViewportMiddle' },
      
      -- ページ移動
      { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
      { key = 'u', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (-0.5) } },
      { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
      { key = 'd', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (0.5) } },
      
      -- 繰り返しジャンプ
      { key = ';', mods = 'NONE', action = act.CopyMode 'JumpAgain' },
      { key = ',', mods = 'NONE', action = act.CopyMode 'JumpReverse' },

      -- ビジュアルモード
      { key = 'v', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
      { key = 'v', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode =  'Block' } },
      { key = 'V', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Line' } },

      -- コピー
      { key = 'y', mods = 'NONE', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },

      -- モード終了
      { key = 'Enter', mods = 'NONE', action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),},
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
    },

  }
}
