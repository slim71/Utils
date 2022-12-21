import win32com.client
import os

def fix_file():
    global filename
    global luxdata_path
    global out_path

    # Open Excel but keep it invisible
    o = win32com.client.Dispatch("Excel.Application")
    o.Visible = False
    o.DisplayAlerts = False  # Overwrite without prompt

    # Set working directories
    input_dir = luxdata_path
    output_dir = out_path

    # Fix corrupted XLS file, exporting it as xlsx
    singlefile = os.path.join(input_dir, filename + ".XLS")
    file = os.path.basename(singlefile)
    output = output_dir + '/' + file.replace('.XLS', '.xlsx')
    wb = o.Workbooks.Open(singlefile)
    wb.ActiveSheet.SaveAs(output, 51)
    wb.Close(True)