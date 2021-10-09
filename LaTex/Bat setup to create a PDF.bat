        :::|----------------------------------------------------------|:::
        :::|                  IMPORTANT NOTE                          |:::
        :::|                                                          |:::
        :::|   Call this from Notepad++ > Run > Run...                |:::
        :::|   using                                                  |:::
        :::|                                                          |:::
        :::| [path_to_bat_file] "$(CURRENT_DIRECTORY)" "$(NAME_PART)" |:::
        :::|                                                          |:::
        :::|----------------------------------------------------------|:::


:: Change Drive and File Directory
%~d1
cd %1
 
:: Run Cleanup and clear the prompt
call:cleanup
cls
@echo off

::==============================================================================
::Ask the user for a choice
:userinput
    echo Which mode would you like to run?
    echo Type 'verbose' (or 'v') to see the complete output of the Tex engine
    echo Type 'quiet' (or 'q') to only get info about warnings and errors
    echo (case insensitive)

::==============================================================================
::Check the user input and acts accordingly
:checking   
    set /P optype=""
    echo.
    IF "%optype:~0,1%"=="Verbose" goto:verbose
    IF "%optype:~0,1%"=="VERBOSE" goto:verbose
    IF "%optype:~0,1%"=="V" goto:verbose
    IF "%optype:~0,1%"=="verbose"  goto:verbose
    IF "%optype:~0,1%"=="v" goto:verbose

    IF "%optype:~0,1%"=="Quiet" goto:quiet
    IF "%optype:~0,1%"=="QUIET" goto:quiet
    IF "%optype:~0,1%"=="Q" goto:quiet
    IF "%optype:~0,1%"=="quiet"  goto:quiet
    IF "%optype:~0,1%"=="q" goto:quiet

    goto:null

:: =============================================================================
::Run preferred Tex engine with complete output
:verbose
    set mode=1
    echo Choosen verbose mode
    echo.
    :: Can be changed to accommodate user preferences
    echo ==================== FIRST pdflatex CALL ====================
    pdflatex %2
    echo.
    echo ===================== FIRST biber CALL ======================
    biber %2
    :: If you are using multibib the following will run bibtex on all aux files
    :: FOR /R . %%G IN (*.aux) DO bibtex %%G
    echo ==================== SECOND pdflatex CALL ====================
    pdflatex %2
    echo.
    echo ==================== THIRD pdflatex CALL ====================
    pdflatex %2
    goto:visualize

::==============================================================================
::Run preferred Tex engine showing only warnings, errors and important notes
:quiet
    set mode=0
    echo Choosen quiet mode
    echo.
    :: Can be changed to accommodate user preferences
    echo ==================== FIRST pdflatex CALL ====================
    pdflatex %2 | findstr /r /c:"^!.*" /i /c:"warning" /i ^
                    /c:"issue" /c:"\l\.[0-9]" /i /c:"underfull" /i /c:"overfull"
    echo.
    echo ==================== FIRST biber CALL ====================
    biber %2 | findstr /r /c:"^!.*" /i /c:"warning" /i /c:"issue" ^
                               /c:"\l\.[0-9]" /i /c:"underfull" /i /c:"overfull"
    echo.
    :: If you are using multibib the following will run bibtex on all aux files
    :: FOR /R . %%G IN (*.aux) DO bibtex %%G
    echo ==================== SECOND pdflatex CALL ====================
    pdflatex %2 | findstr /r /c:"^!.*" /i /c:"warning" /i /c:"issue" ^
                               /c:"\l\.[0-9]" /i /c:"underfull" /i /c:"overfull"
    echo.
    echo ==================== THIRD pdflatex CALL ====================
    pdflatex %2 | findstr /r /c:"^!.*" /i /c:"warning" /i /c:"issue" ^
                               /c:"\l\.[0-9]" /i /c:"underfull" /i /c:"overfull"
    goto:visualize

::==============================================================================
::Open preferred PDF viewer
:visualize
    :: START "" "PATH_TO_PDFVIEWER_EXE" %2.pdf
    ::Example with Sumatra:
    ::   START "" "C:\Progra~2\SumatraPDF\SumatraPDF.exe" %2.pdf -reuse-instance 
    ::Use the system default viewer:
    ::START "" %2.pdf
    START "" "C:\Program Files\SumatraPDF\SumatraPDF.exe" %2.pdf -reuse-instance 

::==============================================================================
::Final messages and computations   
:end
    echo.
    echo ========================== ENDING ===========================
    echo.
    if %mode%==1 pause
    echo.
    call:cleanup
    exit

::==============================================================================
::Wrong input function
:null
    echo Wrong input, please try again
    pause
    goto:end

::==============================================================================
:: Cleanup Function
:cleanup
    :: del *.log
    del *.dvi
    del *.aux
    del *.bbl
    del *.blg
    del *.brf
    del *.out
    goto:eof