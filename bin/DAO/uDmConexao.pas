unit uDmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client;

type
  TDmConexao = class(TDataModule)
    Conexao: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CriaConfig;
    procedure Conectar;
  public
    { Public declarations }
  end;

var
  DmConexao: TDmConexao;

implementation

uses
  Vcl.Forms, System.IniFiles;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmConexao.Conectar;
var
  ArquivoINI: TIniFile;
  caminho, userName, password: string;
begin
  try
    ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\config.ini');

    caminho := ArquivoINI.ReadString('DadosBanco', 'Database', '');
    userName := ArquivoINI.ReadString('DadosBanco', 'User_name', '');
    password := ArquivoINI.ReadString('DadosBanco', 'Passwrod', '');

    Conexao.Params.Values['Database'] := caminho;
    Conexao.Params.Values['User_name'] := userName;
    Conexao.Params.Values['Password'] := password;
    Conexao.Connected := true;

    ArquivoINI.Free;
  except on E:Exception do
    raise Exception.Create('Não foi possivel conectar com o banco de dados.');
  end;
end;

procedure TDmConexao.CriaConfig;
var
  ArquivoINI: TIniFile;
begin
  try
    ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\config.ini');

    ArquivoINI.WriteString('DadosBanco', 'Database', ExtractFilePath(Application.ExeName) + 'db\POSTODFP.fdb');
    ArquivoINI.WriteString('DadosBanco', 'User_name', 'SYSDBA');
    ArquivoINI.WriteString('DadosBanco', 'Passwrod', 'masterkey');

    ArquivoINI.Free;
  except on E:Exception do
    raise Exception.Create('Não foi possivel criar o arquivo de configurações.');
  end;
end;

procedure TDmConexao.DataModuleCreate(Sender: TObject);
begin
  if not FileExists(ExtractFilePath(Application.ExeName) + '\config.ini') then
    CriaConfig;
  Conectar;
end;

end.
