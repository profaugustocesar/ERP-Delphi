unit unCriptografia;

interface

uses
  System.SysUtils,
  System.NetEncoding,
  Winapi.Windows;

type
  TCriptografia = class
  public
    class function Criptografar(const AText: string): string;
    class function Descriptografar(const ABase64: string): string;
  end;

implementation

const
  DPAPI_LOCAL_MACHINE = $00000004;
  DPAPI_UI_FORBIDDEN  = $00000001;

type
  TDataBlob = record
    cbData: DWORD;
    pbData: PByte;
  end;

function DpapiProtect(
  pDataIn: Pointer;
  szDataDescr: PWideChar;
  pOptionalEntropy: Pointer;
  pvReserved: Pointer;
  pPromptStruct: Pointer;
  dwFlags: DWORD;
  pDataOut: Pointer
): BOOL; stdcall; external 'crypt32.dll'
  name 'CryptProtectData';

function DpapiUnprotect(
  pDataIn: Pointer;
  ppszDataDescr: Pointer;
  pOptionalEntropy: Pointer;
  pvReserved: Pointer;
  pPromptStruct: Pointer;
  dwFlags: DWORD;
  pDataOut: Pointer
): BOOL; stdcall; external 'crypt32.dll'
  name 'CryptUnprotectData';


class function TCriptografia.Criptografar(
  const AText: string): string;
var
  PlainBytes, EncryptedBytes: TBytes;
  DataIn, DataOut: TDataBlob;
begin
  if AText = '' then
    raise EArgumentException.Create('Conteúdo Vazio. Nada para criptografar.');

  PlainBytes := TEncoding.UTF8.GetBytes(AText);

  DataIn.cbData := Length(PlainBytes);
  DataIn.pbData := @PlainBytes[0];

  FillChar(DataOut, SizeOf(DataOut), 0);

  if not DpapiProtect(
    @DataIn,
    nil,
    nil,
    nil,
    nil,
    DPAPI_LOCAL_MACHINE or DPAPI_UI_FORBIDDEN,
    @DataOut
  ) then
    RaiseLastOSError;

  try
    SetLength(EncryptedBytes, DataOut.cbData);

    if DataOut.cbData > 0 then
      Move(
        DataOut.pbData^,
        EncryptedBytes[0],
        DataOut.cbData
      );

    Result := TNetEncoding.Base64String
      .EncodeBytesToString(EncryptedBytes);

  finally
    if DataOut.pbData <> nil then
      LocalFree(HLOCAL(DataOut.pbData));
  end;
end;


class function TCriptografia.Descriptografar(
  const ABase64: string): string;
var
  EncryptedBytes, PlainBytes: TBytes;
  DataIn, DataOut: TDataBlob;
begin
  EncryptedBytes := TNetEncoding.Base64String
    .DecodeStringToBytes(ABase64);

  if Length(EncryptedBytes) = 0 then
    raise EArgumentException.Create(
      'Dados criptografados vazios.');

  DataIn.cbData := Length(EncryptedBytes);
  DataIn.pbData := @EncryptedBytes[0];

  FillChar(DataOut, SizeOf(DataOut), 0);

  if not DpapiUnprotect(
    @DataIn,
    nil,
    nil,
    nil,
    nil,
    DPAPI_UI_FORBIDDEN,
    @DataOut
  ) then
    RaiseLastOSError;

  try
    SetLength(PlainBytes, DataOut.cbData);

    if DataOut.cbData > 0 then
      Move(
        DataOut.pbData^,
        PlainBytes[0],
        DataOut.cbData
      );

    Result := TEncoding.UTF8.GetString(PlainBytes);

  finally
    if DataOut.pbData <> nil then
      LocalFree(HLOCAL(DataOut.pbData));
  end;
end;

end.

