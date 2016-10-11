---
layout: post
title: vbs url encode
categories: [cm, windows, vbs]
tags: [cm, vbs, windows, url-encoding]
---

```
' -----------------------
' Function URLEncode
' 参考：
' http://www.experts-exchange.com/Programming/Languages/Visual_Basic/VB_Script/Q_26732683.html
'
Function URLEncode(StringToEncode, UsePlusRatherThanHexForSpace)
  Dim TempAns, CurChr, iChar
  CurChr = 1
  Do Until CurChr - 1 = Len(StringToEncode)
    iChar = Asc(Mid(StringToEncode, CurChr, 1))
    If (iChar > 47 And iChar < 58)  Or (iChar > 64 And iChar < 91) Or (iChar > 96 And iChar < 123) Then
      TempAns = TempAns & Mid(StringToEncode, CurChr, 1)
    ElseIf iChar = 32 Then
      If UsePlusRatherThanHexForSpace Then
        TempAns = TempAns & "+"
      Else
        TempAns = TempAns & "%" & Hex(32)
      End If
    Else
      TempAns = TempAns & "%" & Right("00" & Hex(Asc(Mid(StringToEncode, CurChr, 1))), 2)
    End If
    CurChr = CurChr + 1
  Loop
  URLEncode = TempAns
End Function


' -----------------------
' Function URLEncode
' VBScript/ASP URLEncode function with charset (urlencode to utf-8 or other character encoding)    
' 参考：
' http://www.motobit.com/help/scptutl/sa323.htm
'
Function URLEncode(ByVal Data, CharSet)
  'Create a ByteArray object
  Dim ByteArray: Set ByteArray = CreateObject("ScriptUtils.ByteArray")
  If Len(CharSet)>0 Then ByteArray.CharSet = CharSet
    
  ByteArray.String = Data

  If ByteArray.Length > 0 Then
    Dim I, C, Out

    For I = 1 To ByteArray.Length
      'For each byte of the encoded data
      C = ByteArray(I)
      If C = 32 Then 'convert space to +
        Out = Out + "+"
      ElseIf (C < 48 Or c>126) Or (c>56 And c<=64) Then
        Out = Out + "%" + Hex(C)
      Else
        Out = Out + Chr(c)
      End If
    Next
    URLEncode = Out
  End If
End Function
```


* 其他参考：
  * <http://technet.microsoft.com/en-us/library/ee176816.aspx>

