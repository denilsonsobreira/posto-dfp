unit uBomba;

interface

uses
  uTanque, CustomAttributesUtils;

type
  TBomba = class
    private
      FId: Integer;
      FTanque: TTanque;
      FNome: String;
      procedure SetId(const Value: Integer);
      procedure SetNome(const Value: String);
      procedure SetTanque(const Value: TTanque);
    public
      [ColumnInfo('ID', 'C�digo', 70)]
      property Id : Integer read FId write SetId;

      [ColumnInfo('NOME', 'Nome', 170)]
      [NotNull('O campo nome n�o pode ser vazio.')]
      [MinLength(5, 'O Campo nome deve ter no m�nimo 5 caracteres.')]
      property Nome : String read FNome write SetNome;

      [NotNull('O campo Tanque n�o pode ser vazio.')]
      [ColumnInfo('TANQUE_ID', 'C�digo do Tanque', 150)]
      property Tanque : TTanque read FTanque write SetTanque;
  end;

implementation

{ TBomba }

procedure TBomba.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TBomba.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TBomba.SetTanque(const Value: TTanque);
begin
  FTanque := Value;
end;

end.
