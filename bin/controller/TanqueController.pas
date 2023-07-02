unit TanqueController;

interface

uses
  uTanque, uITanque, Vcl.DBGrids, Vcl.Forms;

type
  TTanqueController = class
    private
      FTanqueDAO: ITanque;
      FTanque: TTanque;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Salvar(Tanque: TTanque; Id: Integer = 0);
      procedure Editar(Id: Integer; aForm: TForm);
      procedure Excluir(Id: Integer);
      procedure ListaTanques(Grid: TDBGrid; Nome: String = '');
      function RetornaTanquePorId(Id: Integer):TTanque;
  end;

implementation

uses
  FDTanque, RttiUtils;


{ TTanqueController }

constructor TTanqueController.Create;
begin
  FTanqueDAO := TFDTanque.Create;
end;

destructor TTanqueController.Destroy;
begin
  inherited;
end;

procedure TTanqueController.Editar(Id: Integer; aForm: TForm);
begin
  TRttiUtils.DataSourceToForm(FTanqueDAO.Editar(id), aForm);
end;

procedure TTanqueController.Excluir(Id: Integer);
begin
  FTanqueDAO.Excluir(id);
end;

procedure TTanqueController.ListaTanques(Grid: TDBGrid; Nome: String);
begin
  FTanque := TTanque.Create;
  TRttiUtils.DataSourceToGrid(FTanqueDAO.ListaTanques(Nome), Grid, FTanque);
  FTanque.Free;
end;

function TTanqueController.RetornaTanquePorId(Id: Integer): TTanque;
begin
  FTanqueDAO.RetornaTanquePorId(Id);
end;

procedure TTanqueController.Salvar(Tanque: TTanque; Id: Integer = 0);
begin
  TRttiUtils.ValidarCampos(Tanque);
  FTanqueDAO.Salvar(Tanque,Id);
end;

end.
