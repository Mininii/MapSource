-- ObserverChat.lua v1.0 Made by Ninfia
-- 관전자 ↔ 플레이어간 채팅을 지원하는 플러그인
-- 2.0부터는 CtrigAsm v5.4.lua에 자동으로 포함됩니다.

function TogglePlayerModerate(PlayerID,State,Timer,TargetPlayer,Condition,Action)
	if State == "Off" then
		Trigger { 
			players = {PlayerID},
			conditions = {
				Memory(0x57EEE4+0x24*TargetPlayer,AtMost,0x0F);
				Condition;
			},
			actions = {
				SetMemoryX(Timer,SetTo,0x80000000,0x80000000);
				Action;
				PreserveTrigger();
			},
		}
		for i = 0, 15 do
			Trigger { 
				players = {PlayerID},
				conditions = {
					MemoryX(Timer,Exactly,0x80000000,0x80000000);
					Memory(0x57EEE4+0x24*TargetPlayer,Exactly,i);
				},
				actions = {
					SetMemoryX(Timer,SetTo,0,0x80000000);
					SetMemoryX(0x57F1D8,SetTo,2^i,2^i);
					PreserveTrigger();
				},
			}
		end
	elseif State == "On" then
		Trigger { 
			players = {PlayerID},
			conditions = {
				Memory(0x57EEE4+0x24*TargetPlayer,AtMost,0x0F);
				Condition;
			},
			actions = {
				SetMemoryX(Timer,SetTo,0x80000000,0x80000000);
				Action;
				PreserveTrigger();
			},
		}
		for i = 0, 15 do
			Trigger { 
				players = {PlayerID},
				conditions = {
					MemoryX(Timer,Exactly,0x80000000,0x80000000);
					Memory(0x57EEE4+0x24*TargetPlayer,Exactly,i);
				},
				actions = {
					SetMemoryX(Timer,SetTo,0,0x80000000);
					SetMemoryX(0x57F1D8,SetTo,0,2^i);
					PreserveTrigger();
				},
			}
		end
	end
end

function TogglePlayerChat(PlayerID,Timer,TargetPlayer,KeyName,Delay,Condition,ActionOn,ActionOff) -- Player→Ob
	function LocalPlayerID(Player,Type)
		if Type == nil then
			Type = Exactly
		end
		if Player == nil then
			return {Memory(0x512684,AtLeast,0),Memory(0x512684,AtMost,7)}
		else
			if Player == "Ob1" then
				Player = 128
			elseif Player == "Ob2" then
				Player = 129
			elseif Player == "Ob3" then
				Player = 130
			elseif Player == "Ob4" then
				Player = 131
			end
			return Memory(0x512684,Type,Player)
		end
	end

	function KeyPress(KeyName,Status) -- 1 = Set(02) / 0 = Cleared(03)
		if Status == "Down" then
			return MemoryB(ParseKeyName(KeyName),Exactly,1)
		elseif Status == "Up" then
			return MemoryB(ParseKeyName(KeyName),Exactly,0)
		else
			KeyPress_InputData_Error()
		end
	end

	function MemoryB(Offset,Type,Value)
		local ret = bit32.band(Offset, 0xFFFFFFFF)%4
		if ret == 0 then
			Mask = 0xFF
		elseif ret == 1 then
			Mask = 0xFF00
			Value = Value * 0x100
		elseif ret == 2 then
			Mask = 0xFF0000
			Value = Value * 0x10000
		elseif ret == 3 then
			Mask = 0xFF000000
			Value = Value * 0x1000000
		end
		return MemoryX(Offset-ret,Type,Value,Mask)
	end

	function ParseKeyName(KeyName)
		local KeyCodeDict = {
		    ['LBUTTON']= 0x01, ['RBUTTON']= 0x02, ['CANCEL']= 0x03, ['MBUTTON']= 0x04,
		    ['XBUTTON1']= 0x05, ['XBUTTON2']= 0x06, ['BACK']= 0x08, ['TAB']= 0x09,
		    ['CLEAR']= 0x0C, ['ENTER']= 0x0D, ['NX5']= 0x0E, ['SHIFT']= 0x10,
		    ['LCTRL']= 0x11, ['LALT']= 0x12, ['PAUSE']= 0x13, ['CAPSLOCK']= 0x14,
		    ['RALT']= 0x15, ['JUNJA']= 0x17, ['FINAL']= 0x18, ['RCTRL']= 0x19, ['ESC']= 0x1B,
		    ['CONVERT']= 0x1C, ['NONCONVERT']= 0x1D, ['ACCEPT']= 0x1E, ['MODECHANGE']= 0x1F,
		    ['SPACE']= 0x20, ['PGUP']= 0x21, ['PGDN']= 0x22, ['END']= 0x23, ['HOME']= 0x24,
		    ['LEFT']= 0x25, ['UP']= 0x26, ['RIGHT']= 0x27, ['DOWN']= 0x28,  -- ARROW keys
		    ['SELECT']= 0x29, ['PRINTSCREEN']= 0x2A, ['EXECUTE']= 0x2B, ['SNAPSHOT']= 0x2C,
		    ['INSERT']= 0x2D, ['DELETE']= 0x2E, ['HELP']= 0x2F,
		    ['0']= 0x30, ['1']= 0x31, ['2']= 0x32, ['3']= 0x33, ['4']= 0x34,
		    ['5']= 0x35, ['6']= 0x36, ['7']= 0x37, ['8']= 0x38, ['9']= 0x39,
		    ['A']= 0x41, ['B']= 0x42, ['C']= 0x43, ['D']= 0x44, ['E']= 0x45, ['F']= 0x46,
		    ['G']= 0x47, ['H']= 0x48, ['I']= 0x49, ['J']= 0x4A, ['K']= 0x4B, ['L']= 0x4C,
		    ['M']= 0x4D, ['N']= 0x4E, ['O']= 0x4F, ['P']= 0x50, ['Q']= 0x51, ['R']= 0x52,
		    ['S']= 0x53, ['T']= 0x54, ['U']= 0x55, ['V']= 0x56, ['W']= 0x57, ['X']= 0x58,
		    ['Y']= 0x59, ['Z']= 0x5A,
		    ['LWIN']= 0x5B, ['RWIN']= 0x5C, ['APPS']= 0x5D, ['SLEEP']= 0x5F,
		    ['NUMPAD0']= 0x60, ['NUMPAD1']= 0x61, ['NUMPAD2']= 0x62, ['NUMPAD3']= 0x63,
		    ['NUMPAD4']= 0x64, ['NUMPAD5']= 0x65, ['NUMPAD6']= 0x66, ['NUMPAD7']= 0x67,
		    ['NUMPAD8']= 0x68, ['NUMPAD9']= 0x69,
		    ['NUMPAD*']= 0x6A, ['NUMPAD+']= 0x6B, ['SEPARATOR']= 0x6C, ['NUMPAD-']= 0x6D,
		    ['NUMPAD.']= 0x6E, ['NUMPAD/']= 0x6F,
		    ['F1']= 0x70, ['F2']= 0x71, ['F3']= 0x72, ['F4']= 0x73, ['F5']= 0x74,
		    ['F6']= 0x75, ['F7']= 0x76, ['F8']= 0x77, ['F9']= 0x78, ['F10']= 0x79,
		    ['F11']= 0x7A, ['F12']= 0x7B, ['F13']= 0x7C, ['F14']= 0x7D, ['F15']= 0x7E,
		    ['F16']= 0x7F, ['F17']= 0x80, ['F18']= 0x81, ['F19']= 0x82, ['F20']= 0x83,
		    ['F21']= 0x84, ['F22']= 0x85, ['F23']= 0x86, ['F24']= 0x87,
		    ['NUMLOCK']= 0x90, ['SCROLL']= 0x91, ['OEM_FJ_JISHO']= 0x92,
		    ['OEM_FJ_MASSHOU']= 0x93, ['OEM_FJ_TOUROKU']= 0x94,
		    ['OEM_FJ_LOYA']= 0x95, ['OEM_FJ_ROYA']= 0x96,
		    ['LSHIFT']= 0xA0, ['RSHIFT']= 0xA1, ['LCONTROL']= 0xA2, ['RCONTROL']= 0xA3,
		    ['LMENU']= 0xA4, ['RMENU']= 0xA5,
		    ['BROWSER_BACK']= 0xA6, ['BROWSER_FORWARD']= 0xA7, ['BROWSER_REFRESH']= 0xA8,
		    ['BROWSER_STOP']= 0xA9, ['BROWSER_SEARCH']= 0xAA, ['BROWSER_FAVORITES']= 0xAB,
		    ['BROWSER_HOME']= 0xAC,
		    ['VOLUME_MUTE']= 0xAD, ['VOLUME_DOWN']= 0xAE, ['VOLUME_UP']= 0xAF,
		    ['MEDIA_NEXT_TRACK']= 0xB0, ['MEDIA_PLAY_PAUSE']= 0xB3,
		    ['MEDIA_PREV_TRACK']= 0xB1, ['MEDIA_STOP']= 0xB2,
		    ['LAUNCH_MAIL']= 0xB4, ['LAUNCH_MEDIA_SELECT']= 0xB5, ['LAUNCH_APP1']= 0xB6,
		    ['LAUNCH_APP2']= 0xB7,
		    ['SEMICOLON']= 0xBA, ['=']= 0xBB, [',']= 0xBC, ['-']= 0xBD, ['.']= 0xBE, ['/']= 0xBF,
		    ['`']= 0xC0, ['ABNT_C1']= 0xC1, ['ABNT_C2']= 0xC2,
		    ['[']= 0xDB, ['|']= 0xDC, [']']= 0xDD, ["'"]= 0xDE, ['OEM_8']= 0xDF,
		    ['OEM_AX']= 0xE1, ['OEM_102']= 0xE2, ['ICO_HELP']= 0xE3, ['ICO_00']= 0xE4,
		    ['PROCESSKEY']= 0xE5, ['ICO_CLEAR']= 0xE6, ['PACKET']= 0xE7, ['OEM_RESET']= 0xE9,
		    ['OEM_JUMP']= 0xEA, ['OEM_PA1']= 0xEB, ['OEM_PA2']= 0xEC, ['OEM_PA3']= 0xED,
		    ['OEM_WSCTRL']= 0xEE, ['OEM_CUSEL']= 0xEF,
		    ['OEM_ATTN']= 0xF0, ['OEM_FINISH']= 0xF1, ['OEM_COPY']= 0xF2, ['OEM_AUTO']= 0xF3,
		    ['OEM_ENLW']= 0xF4, ['OEM_BACKTAB'] = 0xF5, ['ATTN']= 0xF6, ['CRSEL']= 0xF7,
		    ['EXSEL']= 0xF8, ['EREOF']= 0xF9, ['PLAY']= 0xFA, ['ZOOM']= 0xFB, ['NONAME']= 0xFC,
		    ['PA1']= 0xFD, ['OEM_CLEAR']= 0xFE, ['_NONE_']= 0xFF
		}

		local ret = KeyCodeDict[KeyName]
		if ret == nil then
			PushErrorMsg(KeyName.."Doesn't Exist.")
		end
		ret = 0x596A18+ret
		return ret
	end

	function PushErrorMsg(Message)
		_G["\n"..Message.."\n"]() 
	end

	local KeyCond = {}
	if KeyName ~= nil then
		KeyCond = {KeyPress(KeyName,"Down");Memory(0x68C144,Exactly,0)}
	end
	local DelayCond = {MemoryX(Timer,Exactly,0,0x80),MemoryX(Timer,Exactly,0x80,0x80)}
	local DelayAct = {SetMemoryX(Timer,SetTo,0x80,0x80),SetMemoryX(Timer,SetTo,0,0x80)}
	if Delay ~= nil then
		DelayCond = {MemoryX(Timer,Exactly,0,0xFF),MemoryX(Timer,Exactly,0x80,0xFF)}
		DelayAct = {SetMemoryX(Timer,SetTo,0x80+Delay,0xFF),SetMemoryX(Timer,SetTo,Delay,0xFF)}
	end

	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			KeyCond;
			DelayCond[1];
			Condition;
		},
		actions = {
			DelayAct[1];
			ActionOn;
			PreserveTrigger();
		},
	}

	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			KeyCond;
			DelayCond[2];
			Condition;
		},
		actions = {
			DelayAct[2];
			ActionOff;
			PreserveTrigger();
		},
	}

	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			MemoryX(Timer,Exactly,0x80,0x80);
			Memory(0x68C144,AtLeast,1);
		},
		actions = {
			SetMemory(0x68C144,SetTo,5);
			PreserveTrigger();
		},
	}

	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			MemoryX(Timer,AtLeast,1,0x7F);
		},
		actions = {
			SetMemoryX(Timer,Subtract,1,0x7F);
			PreserveTrigger();
		},
	}
end

function ObserverDrop(PlayerID,Timer,TargetPlayer,Delay,Condition,Action) -- "Ob1"~"Ob4"
	function LocalPlayerID(Player,Type)
		if Type == nil then
			Type = Exactly
		end
		if Player == nil then
			return {Memory(0x512684,AtLeast,128),Memory(0x512684,AtMost,131)}
		else
			if Player == "Ob1" then
				Player = 128
			elseif Player == "Ob2" then
				Player = 129
			elseif Player == "Ob3" then
				Player = 130
			elseif Player == "Ob4" then
				Player = 131
			end
			return Memory(0x512684,Type,Player)
		end
	end

	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			MemoryX(Timer,Exactly,0,0xFFF0);
			Condition;
		},
		actions = {
			SetMemoryX(Timer,SetTo,1*16,0xFFF0);
			Action;
		},
	}

	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			MemoryX(Timer,AtLeast,1*16,0xFFF0);
			MemoryX(Timer,AtMost,0xFFE0,0xFFF0);
		},
		actions = {
			SetMemory(0x657A9C,SetTo,0); -- 화면 암전
			SetMemoryX(Timer,Add,1*16,0xFFF0);
			PreserveTrigger();
		},
	}

	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			MemoryX(Timer,AtLeast,Delay*16,0xFFF0);
		},
		actions = {
			SetMemory(0x6509B0,SetTo,8);
			RunAIScript("Turn ON Shared Vision for Player 1");
			RunAIScript("Turn ON Shared Vision for Player 2");
			RunAIScript("Turn ON Shared Vision for Player 3");
			RunAIScript("Turn ON Shared Vision for Player 4");
			RunAIScript("Turn ON Shared Vision for Player 5");
			RunAIScript("Turn ON Shared Vision for Player 6");
			RunAIScript("Turn ON Shared Vision for Player 7");
			RunAIScript("Turn ON Shared Vision for Player 8");
			PreserveTrigger();
		},
	}
end

ObserverChatCheck = 0

function ObserverChatToAll(PlayerID,Timer,TargetPlayer,KeyName,Delay,Condition,Action)
	function LocalPlayerID(Player,Type)
		if Type == nil then
			Type = Exactly
		end
		if Player == nil then
			return {Memory(0x512684,AtLeast,128),Memory(0x512684,AtMost,131)}
		else
			if Player == "Ob1" then
				Player = 128
			elseif Player == "Ob2" then
				Player = 129
			elseif Player == "Ob3" then
				Player = 130
			elseif Player == "Ob4" then
				Player = 131
			end
			return Memory(0x512684,Type,Player)
		end
	end

	function KeyPress(KeyName,Status) -- 1 = Set(02) / 0 = Cleared(03)
		if Status == "Down" then
			return MemoryB(ParseKeyName(KeyName),Exactly,1)
		elseif Status == "Up" then
			return MemoryB(ParseKeyName(KeyName),Exactly,0)
		else
			KeyPress_InputData_Error()
		end
	end

	function MemoryB(Offset,Type,Value)
		local ret = bit32.band(Offset, 0xFFFFFFFF)%4
		if ret == 0 then
			Mask = 0xFF
		elseif ret == 1 then
			Mask = 0xFF00
			Value = Value * 0x100
		elseif ret == 2 then
			Mask = 0xFF0000
			Value = Value * 0x10000
		elseif ret == 3 then
			Mask = 0xFF000000
			Value = Value * 0x1000000
		end
		return MemoryX(Offset-ret,Type,Value,Mask)
	end

	function ParseKeyName(KeyName)
		local KeyCodeDict = {
		    ['LBUTTON']= 0x01, ['RBUTTON']= 0x02, ['CANCEL']= 0x03, ['MBUTTON']= 0x04,
		    ['XBUTTON1']= 0x05, ['XBUTTON2']= 0x06, ['BACK']= 0x08, ['TAB']= 0x09,
		    ['CLEAR']= 0x0C, ['ENTER']= 0x0D, ['NX5']= 0x0E, ['SHIFT']= 0x10,
		    ['LCTRL']= 0x11, ['LALT']= 0x12, ['PAUSE']= 0x13, ['CAPSLOCK']= 0x14,
		    ['RALT']= 0x15, ['JUNJA']= 0x17, ['FINAL']= 0x18, ['RCTRL']= 0x19, ['ESC']= 0x1B,
		    ['CONVERT']= 0x1C, ['NONCONVERT']= 0x1D, ['ACCEPT']= 0x1E, ['MODECHANGE']= 0x1F,
		    ['SPACE']= 0x20, ['PGUP']= 0x21, ['PGDN']= 0x22, ['END']= 0x23, ['HOME']= 0x24,
		    ['LEFT']= 0x25, ['UP']= 0x26, ['RIGHT']= 0x27, ['DOWN']= 0x28,  -- ARROW keys
		    ['SELECT']= 0x29, ['PRINTSCREEN']= 0x2A, ['EXECUTE']= 0x2B, ['SNAPSHOT']= 0x2C,
		    ['INSERT']= 0x2D, ['DELETE']= 0x2E, ['HELP']= 0x2F,
		    ['0']= 0x30, ['1']= 0x31, ['2']= 0x32, ['3']= 0x33, ['4']= 0x34,
		    ['5']= 0x35, ['6']= 0x36, ['7']= 0x37, ['8']= 0x38, ['9']= 0x39,
		    ['A']= 0x41, ['B']= 0x42, ['C']= 0x43, ['D']= 0x44, ['E']= 0x45, ['F']= 0x46,
		    ['G']= 0x47, ['H']= 0x48, ['I']= 0x49, ['J']= 0x4A, ['K']= 0x4B, ['L']= 0x4C,
		    ['M']= 0x4D, ['N']= 0x4E, ['O']= 0x4F, ['P']= 0x50, ['Q']= 0x51, ['R']= 0x52,
		    ['S']= 0x53, ['T']= 0x54, ['U']= 0x55, ['V']= 0x56, ['W']= 0x57, ['X']= 0x58,
		    ['Y']= 0x59, ['Z']= 0x5A,
		    ['LWIN']= 0x5B, ['RWIN']= 0x5C, ['APPS']= 0x5D, ['SLEEP']= 0x5F,
		    ['NUMPAD0']= 0x60, ['NUMPAD1']= 0x61, ['NUMPAD2']= 0x62, ['NUMPAD3']= 0x63,
		    ['NUMPAD4']= 0x64, ['NUMPAD5']= 0x65, ['NUMPAD6']= 0x66, ['NUMPAD7']= 0x67,
		    ['NUMPAD8']= 0x68, ['NUMPAD9']= 0x69,
		    ['NUMPAD*']= 0x6A, ['NUMPAD+']= 0x6B, ['SEPARATOR']= 0x6C, ['NUMPAD-']= 0x6D,
		    ['NUMPAD.']= 0x6E, ['NUMPAD/']= 0x6F,
		    ['F1']= 0x70, ['F2']= 0x71, ['F3']= 0x72, ['F4']= 0x73, ['F5']= 0x74,
		    ['F6']= 0x75, ['F7']= 0x76, ['F8']= 0x77, ['F9']= 0x78, ['F10']= 0x79,
		    ['F11']= 0x7A, ['F12']= 0x7B, ['F13']= 0x7C, ['F14']= 0x7D, ['F15']= 0x7E,
		    ['F16']= 0x7F, ['F17']= 0x80, ['F18']= 0x81, ['F19']= 0x82, ['F20']= 0x83,
		    ['F21']= 0x84, ['F22']= 0x85, ['F23']= 0x86, ['F24']= 0x87,
		    ['NUMLOCK']= 0x90, ['SCROLL']= 0x91, ['OEM_FJ_JISHO']= 0x92,
		    ['OEM_FJ_MASSHOU']= 0x93, ['OEM_FJ_TOUROKU']= 0x94,
		    ['OEM_FJ_LOYA']= 0x95, ['OEM_FJ_ROYA']= 0x96,
		    ['LSHIFT']= 0xA0, ['RSHIFT']= 0xA1, ['LCONTROL']= 0xA2, ['RCONTROL']= 0xA3,
		    ['LMENU']= 0xA4, ['RMENU']= 0xA5,
		    ['BROWSER_BACK']= 0xA6, ['BROWSER_FORWARD']= 0xA7, ['BROWSER_REFRESH']= 0xA8,
		    ['BROWSER_STOP']= 0xA9, ['BROWSER_SEARCH']= 0xAA, ['BROWSER_FAVORITES']= 0xAB,
		    ['BROWSER_HOME']= 0xAC,
		    ['VOLUME_MUTE']= 0xAD, ['VOLUME_DOWN']= 0xAE, ['VOLUME_UP']= 0xAF,
		    ['MEDIA_NEXT_TRACK']= 0xB0, ['MEDIA_PLAY_PAUSE']= 0xB3,
		    ['MEDIA_PREV_TRACK']= 0xB1, ['MEDIA_STOP']= 0xB2,
		    ['LAUNCH_MAIL']= 0xB4, ['LAUNCH_MEDIA_SELECT']= 0xB5, ['LAUNCH_APP1']= 0xB6,
		    ['LAUNCH_APP2']= 0xB7,
		    ['SEMICOLON']= 0xBA, ['=']= 0xBB, [',']= 0xBC, ['-']= 0xBD, ['.']= 0xBE, ['/']= 0xBF,
		    ['`']= 0xC0, ['ABNT_C1']= 0xC1, ['ABNT_C2']= 0xC2,
		    ['[']= 0xDB, ['|']= 0xDC, [']']= 0xDD, ["'"]= 0xDE, ['OEM_8']= 0xDF,
		    ['OEM_AX']= 0xE1, ['OEM_102']= 0xE2, ['ICO_HELP']= 0xE3, ['ICO_00']= 0xE4,
		    ['PROCESSKEY']= 0xE5, ['ICO_CLEAR']= 0xE6, ['PACKET']= 0xE7, ['OEM_RESET']= 0xE9,
		    ['OEM_JUMP']= 0xEA, ['OEM_PA1']= 0xEB, ['OEM_PA2']= 0xEC, ['OEM_PA3']= 0xED,
		    ['OEM_WSCTRL']= 0xEE, ['OEM_CUSEL']= 0xEF,
		    ['OEM_ATTN']= 0xF0, ['OEM_FINISH']= 0xF1, ['OEM_COPY']= 0xF2, ['OEM_AUTO']= 0xF3,
		    ['OEM_ENLW']= 0xF4, ['OEM_BACKTAB'] = 0xF5, ['ATTN']= 0xF6, ['CRSEL']= 0xF7,
		    ['EXSEL']= 0xF8, ['EREOF']= 0xF9, ['PLAY']= 0xFA, ['ZOOM']= 0xFB, ['NONAME']= 0xFC,
		    ['PA1']= 0xFD, ['OEM_CLEAR']= 0xFE, ['_NONE_']= 0xFF
		}

		local ret = KeyCodeDict[KeyName]
		if ret == nil then
			PushErrorMsg(KeyName.."Doesn't Exist.")
		end
		ret = 0x596A18+ret
		return ret
	end

	function PushErrorMsg(Message)
		_G["\n"..Message.."\n"]() 
	end

	local KeyCond = {}
	if KeyName ~= nil then
		KeyCond = {KeyPress(KeyName,"Down");Memory(0x68C144,Exactly,0)}
	end
	local DelayCond = {}
	local DelayAct = {SetMemoryX(Timer,SetTo,0x20000000,0x70000000)}
	if Delay ~= nil then
		DelayCond = {MemoryX(Timer,Exactly,0,0xFF0000)}
		DelayAct = {SetMemoryX(Timer,SetTo,0x20000000+Delay*65536,0x70FF0000)}
	end
	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			KeyCond;
			DelayCond;
			Condition;
		},
		actions = {
			DelayAct;
			Action;
			PreserveTrigger();
		},
	}

	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			MemoryX(Timer,Exactly,0x20000000,0x70000000);
			Memory(0x68C144,AtLeast,1);
		},
		actions = {
			SetMemory(0x68C144,SetTo,2);
			PreserveTrigger();
		},
	}

	if ObserverChatCheck == 0  then
		Trigger { 
			players = {PlayerID},
			conditions = {
				LocalPlayerID(TargetPlayer);
				MemoryX(Timer,AtLeast,1*65536,0xFF0000);
			},
			actions = {
				SetMemoryX(Timer,Subtract,1*65536,0xFF0000);
				PreserveTrigger();
			},
		}
	end
	ObserverChatCheck = 1
end

function ObserverChatToNone(PlayerID,Timer,TargetPlayer,KeyName,Delay,Condition,Action)
	function LocalPlayerID(Player,Type)
		if Type == nil then
			Type = Exactly
		end
		if Player == nil then
			return {Memory(0x512684,AtLeast,128),Memory(0x512684,AtMost,131)}
		else
			if Player == "Ob1" then
				Player = 128
			elseif Player == "Ob2" then
				Player = 129
			elseif Player == "Ob3" then
				Player = 130
			elseif Player == "Ob4" then
				Player = 131
			end
			return Memory(0x512684,Type,Player)
		end
	end

	function KeyPress(KeyName,Status) -- 1 = Set(02) / 0 = Cleared(03)
		if Status == "Down" then
			return MemoryB(ParseKeyName(KeyName),Exactly,1)
		elseif Status == "Up" then
			return MemoryB(ParseKeyName(KeyName),Exactly,0)
		else
			KeyPress_InputData_Error()
		end
	end

	function MemoryB(Offset,Type,Value)
		local ret = bit32.band(Offset, 0xFFFFFFFF)%4
		if ret == 0 then
			Mask = 0xFF
		elseif ret == 1 then
			Mask = 0xFF00
			Value = Value * 0x100
		elseif ret == 2 then
			Mask = 0xFF0000
			Value = Value * 0x10000
		elseif ret == 3 then
			Mask = 0xFF000000
			Value = Value * 0x1000000
		end
		return MemoryX(Offset-ret,Type,Value,Mask)
	end

	function ParseKeyName(KeyName)
		local KeyCodeDict = {
		    ['LBUTTON']= 0x01, ['RBUTTON']= 0x02, ['CANCEL']= 0x03, ['MBUTTON']= 0x04,
		    ['XBUTTON1']= 0x05, ['XBUTTON2']= 0x06, ['BACK']= 0x08, ['TAB']= 0x09,
		    ['CLEAR']= 0x0C, ['ENTER']= 0x0D, ['NX5']= 0x0E, ['SHIFT']= 0x10,
		    ['LCTRL']= 0x11, ['LALT']= 0x12, ['PAUSE']= 0x13, ['CAPSLOCK']= 0x14,
		    ['RALT']= 0x15, ['JUNJA']= 0x17, ['FINAL']= 0x18, ['RCTRL']= 0x19, ['ESC']= 0x1B,
		    ['CONVERT']= 0x1C, ['NONCONVERT']= 0x1D, ['ACCEPT']= 0x1E, ['MODECHANGE']= 0x1F,
		    ['SPACE']= 0x20, ['PGUP']= 0x21, ['PGDN']= 0x22, ['END']= 0x23, ['HOME']= 0x24,
		    ['LEFT']= 0x25, ['UP']= 0x26, ['RIGHT']= 0x27, ['DOWN']= 0x28,  -- ARROW keys
		    ['SELECT']= 0x29, ['PRINTSCREEN']= 0x2A, ['EXECUTE']= 0x2B, ['SNAPSHOT']= 0x2C,
		    ['INSERT']= 0x2D, ['DELETE']= 0x2E, ['HELP']= 0x2F,
		    ['0']= 0x30, ['1']= 0x31, ['2']= 0x32, ['3']= 0x33, ['4']= 0x34,
		    ['5']= 0x35, ['6']= 0x36, ['7']= 0x37, ['8']= 0x38, ['9']= 0x39,
		    ['A']= 0x41, ['B']= 0x42, ['C']= 0x43, ['D']= 0x44, ['E']= 0x45, ['F']= 0x46,
		    ['G']= 0x47, ['H']= 0x48, ['I']= 0x49, ['J']= 0x4A, ['K']= 0x4B, ['L']= 0x4C,
		    ['M']= 0x4D, ['N']= 0x4E, ['O']= 0x4F, ['P']= 0x50, ['Q']= 0x51, ['R']= 0x52,
		    ['S']= 0x53, ['T']= 0x54, ['U']= 0x55, ['V']= 0x56, ['W']= 0x57, ['X']= 0x58,
		    ['Y']= 0x59, ['Z']= 0x5A,
		    ['LWIN']= 0x5B, ['RWIN']= 0x5C, ['APPS']= 0x5D, ['SLEEP']= 0x5F,
		    ['NUMPAD0']= 0x60, ['NUMPAD1']= 0x61, ['NUMPAD2']= 0x62, ['NUMPAD3']= 0x63,
		    ['NUMPAD4']= 0x64, ['NUMPAD5']= 0x65, ['NUMPAD6']= 0x66, ['NUMPAD7']= 0x67,
		    ['NUMPAD8']= 0x68, ['NUMPAD9']= 0x69,
		    ['NUMPAD*']= 0x6A, ['NUMPAD+']= 0x6B, ['SEPARATOR']= 0x6C, ['NUMPAD-']= 0x6D,
		    ['NUMPAD.']= 0x6E, ['NUMPAD/']= 0x6F,
		    ['F1']= 0x70, ['F2']= 0x71, ['F3']= 0x72, ['F4']= 0x73, ['F5']= 0x74,
		    ['F6']= 0x75, ['F7']= 0x76, ['F8']= 0x77, ['F9']= 0x78, ['F10']= 0x79,
		    ['F11']= 0x7A, ['F12']= 0x7B, ['F13']= 0x7C, ['F14']= 0x7D, ['F15']= 0x7E,
		    ['F16']= 0x7F, ['F17']= 0x80, ['F18']= 0x81, ['F19']= 0x82, ['F20']= 0x83,
		    ['F21']= 0x84, ['F22']= 0x85, ['F23']= 0x86, ['F24']= 0x87,
		    ['NUMLOCK']= 0x90, ['SCROLL']= 0x91, ['OEM_FJ_JISHO']= 0x92,
		    ['OEM_FJ_MASSHOU']= 0x93, ['OEM_FJ_TOUROKU']= 0x94,
		    ['OEM_FJ_LOYA']= 0x95, ['OEM_FJ_ROYA']= 0x96,
		    ['LSHIFT']= 0xA0, ['RSHIFT']= 0xA1, ['LCONTROL']= 0xA2, ['RCONTROL']= 0xA3,
		    ['LMENU']= 0xA4, ['RMENU']= 0xA5,
		    ['BROWSER_BACK']= 0xA6, ['BROWSER_FORWARD']= 0xA7, ['BROWSER_REFRESH']= 0xA8,
		    ['BROWSER_STOP']= 0xA9, ['BROWSER_SEARCH']= 0xAA, ['BROWSER_FAVORITES']= 0xAB,
		    ['BROWSER_HOME']= 0xAC,
		    ['VOLUME_MUTE']= 0xAD, ['VOLUME_DOWN']= 0xAE, ['VOLUME_UP']= 0xAF,
		    ['MEDIA_NEXT_TRACK']= 0xB0, ['MEDIA_PLAY_PAUSE']= 0xB3,
		    ['MEDIA_PREV_TRACK']= 0xB1, ['MEDIA_STOP']= 0xB2,
		    ['LAUNCH_MAIL']= 0xB4, ['LAUNCH_MEDIA_SELECT']= 0xB5, ['LAUNCH_APP1']= 0xB6,
		    ['LAUNCH_APP2']= 0xB7,
		    ['SEMICOLON']= 0xBA, ['=']= 0xBB, [',']= 0xBC, ['-']= 0xBD, ['.']= 0xBE, ['/']= 0xBF,
		    ['`']= 0xC0, ['ABNT_C1']= 0xC1, ['ABNT_C2']= 0xC2,
		    ['[']= 0xDB, ['|']= 0xDC, [']']= 0xDD, ["'"]= 0xDE, ['OEM_8']= 0xDF,
		    ['OEM_AX']= 0xE1, ['OEM_102']= 0xE2, ['ICO_HELP']= 0xE3, ['ICO_00']= 0xE4,
		    ['PROCESSKEY']= 0xE5, ['ICO_CLEAR']= 0xE6, ['PACKET']= 0xE7, ['OEM_RESET']= 0xE9,
		    ['OEM_JUMP']= 0xEA, ['OEM_PA1']= 0xEB, ['OEM_PA2']= 0xEC, ['OEM_PA3']= 0xED,
		    ['OEM_WSCTRL']= 0xEE, ['OEM_CUSEL']= 0xEF,
		    ['OEM_ATTN']= 0xF0, ['OEM_FINISH']= 0xF1, ['OEM_COPY']= 0xF2, ['OEM_AUTO']= 0xF3,
		    ['OEM_ENLW']= 0xF4, ['OEM_BACKTAB'] = 0xF5, ['ATTN']= 0xF6, ['CRSEL']= 0xF7,
		    ['EXSEL']= 0xF8, ['EREOF']= 0xF9, ['PLAY']= 0xFA, ['ZOOM']= 0xFB, ['NONAME']= 0xFC,
		    ['PA1']= 0xFD, ['OEM_CLEAR']= 0xFE, ['_NONE_']= 0xFF
		}

		local ret = KeyCodeDict[KeyName]
		if ret == nil then
			PushErrorMsg(KeyName.."Doesn't Exist.")
		end
		ret = 0x596A18+ret
		return ret
	end

	function PushErrorMsg(Message)
		_G["\n"..Message.."\n"]() 
	end

	local KeyCond = {}
	if KeyName ~= nil then
		KeyCond = {KeyPress(KeyName,"Down");Memory(0x68C144,Exactly,0)}
	end
	local DelayCond = {}
	local DelayAct = {SetMemoryX(Timer,SetTo,0x30000000,0x70000000)}
	if Delay ~= nil then
		DelayCond = {MemoryX(Timer,Exactly,0,0xFF0000)}
		DelayAct = {SetMemoryX(Timer,SetTo,0x30000000+Delay*65536,0x70FF0000)}
	end
	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			KeyCond;
			DelayCond;
			Condition;
		},
		actions = {
			DelayAct;
			Action;
			PreserveTrigger();
		},
	}

	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			MemoryX(Timer,Exactly,0x30000000,0x70000000);
			Memory(0x68C144,AtLeast,1);
		},
		actions = {
			SetMemory(0x68C144,SetTo,3);
			PreserveTrigger();
		},
	}

	if ObserverChatCheck == 0  then
		Trigger { 
			players = {PlayerID},
			conditions = {
				LocalPlayerID(TargetPlayer);
				MemoryX(Timer,AtLeast,1*65536,0xFF0000);
			},
			actions = {
				SetMemoryX(Timer,Subtract,1*65536,0xFF0000);
				PreserveTrigger();
			},
		}
	end
	ObserverChatCheck = 1
end

function ObserverChatToPlayer(PlayerID,Timer,TargetPlayer,KeyName,Delay,Condition,ActionArray)
	function LocalPlayerID(Player,Type)
		if Type == nil then
			Type = Exactly
		end
		if Player == nil then
			return {Memory(0x512684,AtLeast,128),Memory(0x512684,AtMost,131)}
		else
			if Player == "Ob1" then
				Player = 128
			elseif Player == "Ob2" then
				Player = 129
			elseif Player == "Ob3" then
				Player = 130
			elseif Player == "Ob4" then
				Player = 131
			end
			return Memory(0x512684,Type,Player)
		end
	end

	function KeyPress(KeyName,Status) -- 1 = Set(02) / 0 = Cleared(03)
		if Status == "Down" then
			return MemoryB(ParseKeyName(KeyName),Exactly,1)
		elseif Status == "Up" then
			return MemoryB(ParseKeyName(KeyName),Exactly,0)
		else
			KeyPress_InputData_Error()
		end
	end

	function MemoryB(Offset,Type,Value)
		local ret = bit32.band(Offset, 0xFFFFFFFF)%4
		if ret == 0 then
			Mask = 0xFF
		elseif ret == 1 then
			Mask = 0xFF00
			Value = Value * 0x100
		elseif ret == 2 then
			Mask = 0xFF0000
			Value = Value * 0x10000
		elseif ret == 3 then
			Mask = 0xFF000000
			Value = Value * 0x1000000
		end
		return MemoryX(Offset-ret,Type,Value,Mask)
	end

	function ParseKeyName(KeyName)
		local KeyCodeDict = {
		    ['LBUTTON']= 0x01, ['RBUTTON']= 0x02, ['CANCEL']= 0x03, ['MBUTTON']= 0x04,
		    ['XBUTTON1']= 0x05, ['XBUTTON2']= 0x06, ['BACK']= 0x08, ['TAB']= 0x09,
		    ['CLEAR']= 0x0C, ['ENTER']= 0x0D, ['NX5']= 0x0E, ['SHIFT']= 0x10,
		    ['LCTRL']= 0x11, ['LALT']= 0x12, ['PAUSE']= 0x13, ['CAPSLOCK']= 0x14,
		    ['RALT']= 0x15, ['JUNJA']= 0x17, ['FINAL']= 0x18, ['RCTRL']= 0x19, ['ESC']= 0x1B,
		    ['CONVERT']= 0x1C, ['NONCONVERT']= 0x1D, ['ACCEPT']= 0x1E, ['MODECHANGE']= 0x1F,
		    ['SPACE']= 0x20, ['PGUP']= 0x21, ['PGDN']= 0x22, ['END']= 0x23, ['HOME']= 0x24,
		    ['LEFT']= 0x25, ['UP']= 0x26, ['RIGHT']= 0x27, ['DOWN']= 0x28,  -- ARROW keys
		    ['SELECT']= 0x29, ['PRINTSCREEN']= 0x2A, ['EXECUTE']= 0x2B, ['SNAPSHOT']= 0x2C,
		    ['INSERT']= 0x2D, ['DELETE']= 0x2E, ['HELP']= 0x2F,
		    ['0']= 0x30, ['1']= 0x31, ['2']= 0x32, ['3']= 0x33, ['4']= 0x34,
		    ['5']= 0x35, ['6']= 0x36, ['7']= 0x37, ['8']= 0x38, ['9']= 0x39,
		    ['A']= 0x41, ['B']= 0x42, ['C']= 0x43, ['D']= 0x44, ['E']= 0x45, ['F']= 0x46,
		    ['G']= 0x47, ['H']= 0x48, ['I']= 0x49, ['J']= 0x4A, ['K']= 0x4B, ['L']= 0x4C,
		    ['M']= 0x4D, ['N']= 0x4E, ['O']= 0x4F, ['P']= 0x50, ['Q']= 0x51, ['R']= 0x52,
		    ['S']= 0x53, ['T']= 0x54, ['U']= 0x55, ['V']= 0x56, ['W']= 0x57, ['X']= 0x58,
		    ['Y']= 0x59, ['Z']= 0x5A,
		    ['LWIN']= 0x5B, ['RWIN']= 0x5C, ['APPS']= 0x5D, ['SLEEP']= 0x5F,
		    ['NUMPAD0']= 0x60, ['NUMPAD1']= 0x61, ['NUMPAD2']= 0x62, ['NUMPAD3']= 0x63,
		    ['NUMPAD4']= 0x64, ['NUMPAD5']= 0x65, ['NUMPAD6']= 0x66, ['NUMPAD7']= 0x67,
		    ['NUMPAD8']= 0x68, ['NUMPAD9']= 0x69,
		    ['NUMPAD*']= 0x6A, ['NUMPAD+']= 0x6B, ['SEPARATOR']= 0x6C, ['NUMPAD-']= 0x6D,
		    ['NUMPAD.']= 0x6E, ['NUMPAD/']= 0x6F,
		    ['F1']= 0x70, ['F2']= 0x71, ['F3']= 0x72, ['F4']= 0x73, ['F5']= 0x74,
		    ['F6']= 0x75, ['F7']= 0x76, ['F8']= 0x77, ['F9']= 0x78, ['F10']= 0x79,
		    ['F11']= 0x7A, ['F12']= 0x7B, ['F13']= 0x7C, ['F14']= 0x7D, ['F15']= 0x7E,
		    ['F16']= 0x7F, ['F17']= 0x80, ['F18']= 0x81, ['F19']= 0x82, ['F20']= 0x83,
		    ['F21']= 0x84, ['F22']= 0x85, ['F23']= 0x86, ['F24']= 0x87,
		    ['NUMLOCK']= 0x90, ['SCROLL']= 0x91, ['OEM_FJ_JISHO']= 0x92,
		    ['OEM_FJ_MASSHOU']= 0x93, ['OEM_FJ_TOUROKU']= 0x94,
		    ['OEM_FJ_LOYA']= 0x95, ['OEM_FJ_ROYA']= 0x96,
		    ['LSHIFT']= 0xA0, ['RSHIFT']= 0xA1, ['LCONTROL']= 0xA2, ['RCONTROL']= 0xA3,
		    ['LMENU']= 0xA4, ['RMENU']= 0xA5,
		    ['BROWSER_BACK']= 0xA6, ['BROWSER_FORWARD']= 0xA7, ['BROWSER_REFRESH']= 0xA8,
		    ['BROWSER_STOP']= 0xA9, ['BROWSER_SEARCH']= 0xAA, ['BROWSER_FAVORITES']= 0xAB,
		    ['BROWSER_HOME']= 0xAC,
		    ['VOLUME_MUTE']= 0xAD, ['VOLUME_DOWN']= 0xAE, ['VOLUME_UP']= 0xAF,
		    ['MEDIA_NEXT_TRACK']= 0xB0, ['MEDIA_PLAY_PAUSE']= 0xB3,
		    ['MEDIA_PREV_TRACK']= 0xB1, ['MEDIA_STOP']= 0xB2,
		    ['LAUNCH_MAIL']= 0xB4, ['LAUNCH_MEDIA_SELECT']= 0xB5, ['LAUNCH_APP1']= 0xB6,
		    ['LAUNCH_APP2']= 0xB7,
		    ['SEMICOLON']= 0xBA, ['=']= 0xBB, [',']= 0xBC, ['-']= 0xBD, ['.']= 0xBE, ['/']= 0xBF,
		    ['`']= 0xC0, ['ABNT_C1']= 0xC1, ['ABNT_C2']= 0xC2,
		    ['[']= 0xDB, ['|']= 0xDC, [']']= 0xDD, ["'"]= 0xDE, ['OEM_8']= 0xDF,
		    ['OEM_AX']= 0xE1, ['OEM_102']= 0xE2, ['ICO_HELP']= 0xE3, ['ICO_00']= 0xE4,
		    ['PROCESSKEY']= 0xE5, ['ICO_CLEAR']= 0xE6, ['PACKET']= 0xE7, ['OEM_RESET']= 0xE9,
		    ['OEM_JUMP']= 0xEA, ['OEM_PA1']= 0xEB, ['OEM_PA2']= 0xEC, ['OEM_PA3']= 0xED,
		    ['OEM_WSCTRL']= 0xEE, ['OEM_CUSEL']= 0xEF,
		    ['OEM_ATTN']= 0xF0, ['OEM_FINISH']= 0xF1, ['OEM_COPY']= 0xF2, ['OEM_AUTO']= 0xF3,
		    ['OEM_ENLW']= 0xF4, ['OEM_BACKTAB'] = 0xF5, ['ATTN']= 0xF6, ['CRSEL']= 0xF7,
		    ['EXSEL']= 0xF8, ['EREOF']= 0xF9, ['PLAY']= 0xFA, ['ZOOM']= 0xFB, ['NONAME']= 0xFC,
		    ['PA1']= 0xFD, ['OEM_CLEAR']= 0xFE, ['_NONE_']= 0xFF
		}

		local ret = KeyCodeDict[KeyName]
		if ret == nil then
			PushErrorMsg(KeyName.."Doesn't Exist.")
		end
		ret = 0x596A18+ret
		return ret
	end

	function PushErrorMsg(Message)
		_G["\n"..Message.."\n"]() 
	end

	local KeyCond = {}
	if KeyName ~= nil then
		KeyCond = {KeyPress(KeyName,"Down");Memory(0x68C144,Exactly,0)}
	end
	
	if ActionArray == nil then ActionArray = {} end

	for i = 0, 7 do
		if ActionArray[i+1] == nil then ActionArray[i+1] = {} end
		local j = (i+7)%8

		local DelayCond = {MemoryX(Timer,Exactly,j*0x01000000,0x0F00000F)}
		local DelayAct = {SetMemoryX(Timer,SetTo,0xC0000000,0xF0000000)}
		if Delay ~= nil then
			DelayCond = {MemoryX(Timer,Exactly,j*0x01000000,0x0FFF000F)}
			DelayAct = {SetMemoryX(Timer,SetTo,0xC0000000+Delay*65536,0xF0FF0000)}
		end
		
		Trigger { 
			players = {PlayerID},
			conditions = {
				LocalPlayerID(TargetPlayer);
				KeyCond;
				DelayCond;
				Condition;
			},
			actions = {
				DelayAct;
				PreserveTrigger();
			},
		}

		for k = 0, 7 do
			local l = (k+i)%8
			Trigger { 
				players = {PlayerID},
				conditions = {
					LocalPlayerID(TargetPlayer);
					MemoryX(Timer,Exactly,0x80000000,0x80000000);
					Memory(0x57EEE4+0x24*l,AtMost,0x0F);
				},
				actions = {
					SetMemoryX(Timer,SetTo,l*0x01000000+(l+1),0x8F00000F);
					PreserveTrigger();
				},
			}
		end
	end

	for i = 0, 7 do
		Trigger { 
			players = {PlayerID},
			conditions = {
				LocalPlayerID(TargetPlayer);
				MemoryX(Timer,Exactly,i+1+0x40000000,0x4000000F);
			},
			actions = {
				ActionArray[i+1];
				SetMemoryX(Timer,SetTo,0,0xF);
				PreserveTrigger();
			},
		}
	end

	for i = 0, 7 do
		for j = 3, 0, -1 do
			Trigger { 
				players = {PlayerID},
				conditions = {
					LocalPlayerID(TargetPlayer);
					MemoryX(Timer,Exactly,0x40000000+i*0x01000000,0x7F000000);
					MemoryX(0x57EEE4+0x24*i,Exactly,2^j,2^j);
				},
				actions = {
					SetMemoryX(Timer,SetTo,2^j,2^j);
					PreserveTrigger();
				},
			}
		end
	end

	for i = 0, 15 do
		Trigger { 
			players = {PlayerID},
			conditions = {
				LocalPlayerID(TargetPlayer);
				MemoryX(Timer,Exactly,0x40000000+i,0x7000000F);
			},
			actions = {
				SetMemoryX(0x57F1D8,SetTo,2^(i+16),0xFFFF0000);
				SetMemoryX(Timer,SetTo,0,0xF);
				PreserveTrigger();
			},
		}
	end

	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			MemoryX(Timer,Exactly,0x40000000,0x70000000);
			Memory(0x68C144,AtLeast,1);
		},
		actions = {
			SetMemory(0x68C144,SetTo,4);
			PreserveTrigger();
		},
	}

	if ObserverChatCheck == 0  then
		Trigger { 
			players = {PlayerID},
			conditions = {
				LocalPlayerID(TargetPlayer);
				MemoryX(Timer,AtLeast,1*65536,0xFF0000);
			},
			actions = {
				SetMemoryX(Timer,Subtract,1*65536,0xFF0000);
				PreserveTrigger();
			},
		}
	end
	ObserverChatCheck = 1
end

function ObserverChatToOb(PlayerID,Timer,TargetPlayer,KeyName,Delay,Condition,Action)
	function LocalPlayerID(Player,Type)
		if Type == nil then
			Type = Exactly
		end
		if Player == nil then
			return {Memory(0x512684,AtLeast,128),Memory(0x512684,AtMost,131)}
		else
			if Player == "Ob1" then
				Player = 128
			elseif Player == "Ob2" then
				Player = 129
			elseif Player == "Ob3" then
				Player = 130
			elseif Player == "Ob4" then
				Player = 131
			end
			return Memory(0x512684,Type,Player)
		end
	end

	function KeyPress(KeyName,Status) -- 1 = Set(02) / 0 = Cleared(03)
		if Status == "Down" then
			return MemoryB(ParseKeyName(KeyName),Exactly,1)
		elseif Status == "Up" then
			return MemoryB(ParseKeyName(KeyName),Exactly,0)
		else
			KeyPress_InputData_Error()
		end
	end

	function MemoryB(Offset,Type,Value)
		local ret = bit32.band(Offset, 0xFFFFFFFF)%4
		if ret == 0 then
			Mask = 0xFF
		elseif ret == 1 then
			Mask = 0xFF00
			Value = Value * 0x100
		elseif ret == 2 then
			Mask = 0xFF0000
			Value = Value * 0x10000
		elseif ret == 3 then
			Mask = 0xFF000000
			Value = Value * 0x1000000
		end
		return MemoryX(Offset-ret,Type,Value,Mask)
	end

	function ParseKeyName(KeyName)
		local KeyCodeDict = {
		    ['LBUTTON']= 0x01, ['RBUTTON']= 0x02, ['CANCEL']= 0x03, ['MBUTTON']= 0x04,
		    ['XBUTTON1']= 0x05, ['XBUTTON2']= 0x06, ['BACK']= 0x08, ['TAB']= 0x09,
		    ['CLEAR']= 0x0C, ['ENTER']= 0x0D, ['NX5']= 0x0E, ['SHIFT']= 0x10,
		    ['LCTRL']= 0x11, ['LALT']= 0x12, ['PAUSE']= 0x13, ['CAPSLOCK']= 0x14,
		    ['RALT']= 0x15, ['JUNJA']= 0x17, ['FINAL']= 0x18, ['RCTRL']= 0x19, ['ESC']= 0x1B,
		    ['CONVERT']= 0x1C, ['NONCONVERT']= 0x1D, ['ACCEPT']= 0x1E, ['MODECHANGE']= 0x1F,
		    ['SPACE']= 0x20, ['PGUP']= 0x21, ['PGDN']= 0x22, ['END']= 0x23, ['HOME']= 0x24,
		    ['LEFT']= 0x25, ['UP']= 0x26, ['RIGHT']= 0x27, ['DOWN']= 0x28,  -- ARROW keys
		    ['SELECT']= 0x29, ['PRINTSCREEN']= 0x2A, ['EXECUTE']= 0x2B, ['SNAPSHOT']= 0x2C,
		    ['INSERT']= 0x2D, ['DELETE']= 0x2E, ['HELP']= 0x2F,
		    ['0']= 0x30, ['1']= 0x31, ['2']= 0x32, ['3']= 0x33, ['4']= 0x34,
		    ['5']= 0x35, ['6']= 0x36, ['7']= 0x37, ['8']= 0x38, ['9']= 0x39,
		    ['A']= 0x41, ['B']= 0x42, ['C']= 0x43, ['D']= 0x44, ['E']= 0x45, ['F']= 0x46,
		    ['G']= 0x47, ['H']= 0x48, ['I']= 0x49, ['J']= 0x4A, ['K']= 0x4B, ['L']= 0x4C,
		    ['M']= 0x4D, ['N']= 0x4E, ['O']= 0x4F, ['P']= 0x50, ['Q']= 0x51, ['R']= 0x52,
		    ['S']= 0x53, ['T']= 0x54, ['U']= 0x55, ['V']= 0x56, ['W']= 0x57, ['X']= 0x58,
		    ['Y']= 0x59, ['Z']= 0x5A,
		    ['LWIN']= 0x5B, ['RWIN']= 0x5C, ['APPS']= 0x5D, ['SLEEP']= 0x5F,
		    ['NUMPAD0']= 0x60, ['NUMPAD1']= 0x61, ['NUMPAD2']= 0x62, ['NUMPAD3']= 0x63,
		    ['NUMPAD4']= 0x64, ['NUMPAD5']= 0x65, ['NUMPAD6']= 0x66, ['NUMPAD7']= 0x67,
		    ['NUMPAD8']= 0x68, ['NUMPAD9']= 0x69,
		    ['NUMPAD*']= 0x6A, ['NUMPAD+']= 0x6B, ['SEPARATOR']= 0x6C, ['NUMPAD-']= 0x6D,
		    ['NUMPAD.']= 0x6E, ['NUMPAD/']= 0x6F,
		    ['F1']= 0x70, ['F2']= 0x71, ['F3']= 0x72, ['F4']= 0x73, ['F5']= 0x74,
		    ['F6']= 0x75, ['F7']= 0x76, ['F8']= 0x77, ['F9']= 0x78, ['F10']= 0x79,
		    ['F11']= 0x7A, ['F12']= 0x7B, ['F13']= 0x7C, ['F14']= 0x7D, ['F15']= 0x7E,
		    ['F16']= 0x7F, ['F17']= 0x80, ['F18']= 0x81, ['F19']= 0x82, ['F20']= 0x83,
		    ['F21']= 0x84, ['F22']= 0x85, ['F23']= 0x86, ['F24']= 0x87,
		    ['NUMLOCK']= 0x90, ['SCROLL']= 0x91, ['OEM_FJ_JISHO']= 0x92,
		    ['OEM_FJ_MASSHOU']= 0x93, ['OEM_FJ_TOUROKU']= 0x94,
		    ['OEM_FJ_LOYA']= 0x95, ['OEM_FJ_ROYA']= 0x96,
		    ['LSHIFT']= 0xA0, ['RSHIFT']= 0xA1, ['LCONTROL']= 0xA2, ['RCONTROL']= 0xA3,
		    ['LMENU']= 0xA4, ['RMENU']= 0xA5,
		    ['BROWSER_BACK']= 0xA6, ['BROWSER_FORWARD']= 0xA7, ['BROWSER_REFRESH']= 0xA8,
		    ['BROWSER_STOP']= 0xA9, ['BROWSER_SEARCH']= 0xAA, ['BROWSER_FAVORITES']= 0xAB,
		    ['BROWSER_HOME']= 0xAC,
		    ['VOLUME_MUTE']= 0xAD, ['VOLUME_DOWN']= 0xAE, ['VOLUME_UP']= 0xAF,
		    ['MEDIA_NEXT_TRACK']= 0xB0, ['MEDIA_PLAY_PAUSE']= 0xB3,
		    ['MEDIA_PREV_TRACK']= 0xB1, ['MEDIA_STOP']= 0xB2,
		    ['LAUNCH_MAIL']= 0xB4, ['LAUNCH_MEDIA_SELECT']= 0xB5, ['LAUNCH_APP1']= 0xB6,
		    ['LAUNCH_APP2']= 0xB7,
		    ['SEMICOLON']= 0xBA, ['=']= 0xBB, [',']= 0xBC, ['-']= 0xBD, ['.']= 0xBE, ['/']= 0xBF,
		    ['`']= 0xC0, ['ABNT_C1']= 0xC1, ['ABNT_C2']= 0xC2,
		    ['[']= 0xDB, ['|']= 0xDC, [']']= 0xDD, ["'"]= 0xDE, ['OEM_8']= 0xDF,
		    ['OEM_AX']= 0xE1, ['OEM_102']= 0xE2, ['ICO_HELP']= 0xE3, ['ICO_00']= 0xE4,
		    ['PROCESSKEY']= 0xE5, ['ICO_CLEAR']= 0xE6, ['PACKET']= 0xE7, ['OEM_RESET']= 0xE9,
		    ['OEM_JUMP']= 0xEA, ['OEM_PA1']= 0xEB, ['OEM_PA2']= 0xEC, ['OEM_PA3']= 0xED,
		    ['OEM_WSCTRL']= 0xEE, ['OEM_CUSEL']= 0xEF,
		    ['OEM_ATTN']= 0xF0, ['OEM_FINISH']= 0xF1, ['OEM_COPY']= 0xF2, ['OEM_AUTO']= 0xF3,
		    ['OEM_ENLW']= 0xF4, ['OEM_BACKTAB'] = 0xF5, ['ATTN']= 0xF6, ['CRSEL']= 0xF7,
		    ['EXSEL']= 0xF8, ['EREOF']= 0xF9, ['PLAY']= 0xFA, ['ZOOM']= 0xFB, ['NONAME']= 0xFC,
		    ['PA1']= 0xFD, ['OEM_CLEAR']= 0xFE, ['_NONE_']= 0xFF
		}

		local ret = KeyCodeDict[KeyName]
		if ret == nil then
			PushErrorMsg(KeyName.."Doesn't Exist.")
		end
		ret = 0x596A18+ret
		return ret
	end

	function PushErrorMsg(Message)
		_G["\n"..Message.."\n"]() 
	end

	local KeyCond = {}
	if KeyName ~= nil then
		KeyCond = {KeyPress(KeyName,"Down");Memory(0x68C144,Exactly,0)}
	end
	local DelayCond = {}
	local DelayAct = {SetMemoryX(Timer,SetTo,0x50000000,0x70000000)}
	if Delay ~= nil then
		DelayCond = {MemoryX(Timer,Exactly,0,0xFF0000)}
		DelayAct = {SetMemoryX(Timer,SetTo,0x50000000+Delay*65536,0x70FF0000)}
	end
	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			KeyCond;
			DelayCond;
			Condition;
		},
		actions = {
			DelayAct;
			Action;
			PreserveTrigger();
		},
	}

	Trigger { 
		players = {PlayerID},
		conditions = {
			LocalPlayerID(TargetPlayer);
			MemoryX(Timer,Exactly,0x50000000,0x70000000);
			Memory(0x68C144,AtLeast,1);
		},
		actions = {
			SetMemory(0x68C144,SetTo,5);
			PreserveTrigger();
		},
	}

	if ObserverChatCheck == 0  then
		Trigger { 
			players = {PlayerID},
			conditions = {
				LocalPlayerID(TargetPlayer);
				MemoryX(Timer,AtLeast,1*65536,0xFF0000);
			},
			actions = {
				SetMemoryX(Timer,Subtract,1*65536,0xFF0000);
				PreserveTrigger();
			},
		}
	end
	ObserverChatCheck = 1
end



