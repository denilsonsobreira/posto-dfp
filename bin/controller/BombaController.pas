unit BombaController;

interface

uses
  Vcl.DBGrids, uIBomba, uBomba, Vcl.Forms, Data.DB, uITanque, uTanque;

type
  TBombaController = class
    private
      FBombaDAO: IBomba;
      FBomba: TBomba;
      FTanqueDAO: ITanque;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Salvar(Bomba: TBomba; Id: Integer = 0);
      procedure ListaBombas(Grid: TDBGrid; Nome: String = '');
      procedure Editar(Id: Integer; aForm: TForm);
      function PesquisaTanques(): TDatasource;
      function RetornaTanque(TanqueId: Integer): TTanque;
      function RetornaNomeTanque(Id: Integer): String;
      procedure Excluir(Id: Integer);
      function RetornaBombaPorId(Id: Integer): TBomba;
  end;

implementation

uses
  FDBomba, RttiUtils, FDTanque;

{ TBombaController }

constructor TBombaController.Create;
begin
  FBombaDAO := TFDBomba.Create;
  FTanqueDAO := TFDTanque.Create;
end;

destructor TBombaController.Destroy;
begin
  inherited;
end;

procedure TBombaController.Editar(Id: Integer; aForm: TForm);
begin
  TRttiUtils.DataSourceToForm(FBombaDAO.Editar(id), aForm);
end;

procedure TBombaController.Excluir(Id: Integer);
begin
  FBombaDAO.Excluir(Id);
end;

procedure TBombaController.ListaBombas(Grid: TDBGrid; Nome: String);
begin
  FBomba := TBomba.Create;
  TRttiUtils.DataSourceToGrid(FBombaDAO.ListaBombas(Nome), Grid, FBomba);
  FBomba.Free;
end;

function TBombaController.PesquisaTanques: TDatasource;
begin
  Result := FTanqueDAO.ListaTanques();
end;

function TBombaController.RetornaBombaPorId(Id: Integer): TBomba;
begin
  Result := FBombaDAO.RetornaBombaPorId(Id);
end;

function TBombaController.RetornaNomeTanque(Id: Integer): String;
begin
  Result := FTanqueDAO.RetornaNomeTanque(id);
end;

function TBombaController.RetornaTanque(TanqueId: Integer): TTanque;
begin
  Result := FTanqueDAO.RetornaTanquePorId(TanqueId);
end;

procedure TBombaController.Salvar(Bomba: TBomba; Id: Integer);
begin
  TRttiUtils.ValidarCampos(Bomba);
  FBombaDAO.Salvar(Bomba,Id);
end;

end.
