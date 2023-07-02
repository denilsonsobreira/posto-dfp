unit RttiUtils;

interface

uses
  Data.DB, Vcl.DBGrids, CustomAttributesUtils, Vcl.Forms;

type
  TRttiUtils = class
    private
    public
      class procedure DataSourceToGrid(aDataSource: TDataSource; Grid: TDBGrid; aObject: TObject);
      class procedure DataSourceToForm(aDataSource: TDataSource; aForm: TForm);
      class procedure ValidarCampos(aObject: TObject);
  end;

implementation

uses
  System.Rtti, System.Classes, System.UITypes, Vcl.StdCtrls, System.TypInfo,
  System.SysUtils;

{ TRttiUtils }

class procedure TRttiUtils.DataSourceToForm(aDataSource: TDataSource; aForm: TForm);
var
  ctxRtti: TRttiContext;
  typeRtti: TRttiType;
  fieldRtti: TRttiField;
  cstAttr: TCustomAttribute;
  Component: TComponent;
begin
  ctxRtti := TRttiContext.Create;
  try
    typeRtti := ctxRtti.GetType(aForm.ClassType);
    for fieldRtti in typeRtti.GetFields do
      for cstAttr in fieldRtti.GetAttributes do
        begin
          if cstAttr is Bind then
            begin
              Component := aForm.FindComponent(fieldRtti.Name);
              if Component is TEdit then
                TEdit(Component).Text := aDataSource.DataSet.FieldByName(Bind(cstAttr).Field).AsString;

              if Component is TComboBox then
                TComboBox(Component).ItemIndex := aDataSource.DataSet.FieldByName(Bind(cstAttr).Field).AsInteger;
            end;
        end;
  finally
    ctxRtti.Free;
  end;
end;

class procedure TRttiUtils.DataSourceToGrid(aDataSource: TDataSource; Grid: TDBGrid; aObject: TObject);
var
  ctxRtti: TRttiContext;
  typeRtti: TRttiType;
  prpRtti: TRttiProperty;
  custAtr: TCustomAttribute;
  enumRtti: TRttiEnumerationType;
  i: Integer;
begin
  ctxRtti := TRttiContext.Create;
  if aDataSource.DataSet.RecordCount > 0 then
    Grid.DataSource := aDataSource
  else
    begin
      Grid.DataSource := nil;
      exit;
    end;
  try
    typeRtti := ctxRtti.GetType(aObject.ClassType);
    for prpRtti in typeRtti.GetProperties do
      for custAtr in prpRtti.GetAttributes do
        begin
          if custAtr is ColumnInfo then
            begin
              for i := 0 to aDataSource.DataSet.Fields.Count - 1 do
                begin
                  if ColumnInfo(custAtr).DBName = aDataSource.DataSet.Fields[i].FieldName then
                    begin
                      Grid.Columns[i].Title.Caption := ColumnInfo(custAtr).Name;
                      Grid.Columns[i].Title.Font.Size := 10;
                      Grid.Columns[i].Title.Font.Style := [TFontStyle.fsBold];
                      Grid.Columns[i].Width := ColumnInfo(custAtr).Width;
                      Grid.Columns[i].Alignment := taLeftJustify;
                    end;

                end;
            end;
        end;
  finally
    ctxRtti.Free;
  end;
end;

class procedure TRttiUtils.ValidarCampos(aObject: TObject);
var
  ctxRtti: TRttiContext;
  typeRtti: TRttiType;
  prpRtti: TRttiProperty;
  custAtr: TCustomAttribute;
  s: string;
  valorTanque: TValue;
  propriedadeNome: TRttiProperty;
begin
  ctxRtti := TRttiContext.Create;
  try
    typeRtti := ctxRtti.GetType(aObject.ClassType);
    for prpRtti in typeRtti.GetProperties do
      for custAtr in prpRtti.GetAttributes do
        begin
          //attr NotNull
          if custAtr is NotNull then
            begin
              case prpRtti.GetValue(aObject).TypeInfo.Kind of
                tkUString:
                  begin
                    if prpRtti.GetValue(aObject).AsString.Trim.IsEmpty then
                      raise Exception.Create(NotNull(custAtr).Mensagem);
                  end;
                  tkClass:
                    begin
                      if prpRtti.GetValue(aObject).AsObject = nil then
                        raise Exception.Create(NotNull(custAtr).Mensagem);
                    end;
              end;
            end;

          //attr MinLength
          if custAtr is MinLength then
            begin
              case prpRtti.GetValue(aObject).TypeInfo.Kind of
                tkUString:
                  begin
                    if Length(prpRtti.GetValue(aObject).AsString) < (MinLength(custAtr).Length) then
                      raise Exception.Create(MinLength(custAtr).Msg);
                  end;
              end;
            end;

        end;

  finally
    ctxRtti.Free;
  end;
end;

end.
