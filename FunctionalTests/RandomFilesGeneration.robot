*** Settings ***
Library    OperatingSystem
Library    String


*** Variables ***
${DIR}	Test_directory


*** Test Cases ***
Create and Display Random Files
	[Documentation]	ALL FILE NAMES
	Directory with File

*** Keywords ***
Directory with File
	${exists}=    Run Keyword And Return Status    Directory Should Exist    Test_directory

	IF	${exists}
        Log    Directory exists!
		${anyfiles}=    List Files In Directory    ${DIR}

    	IF    ${anyfiles}
			Log 	file exists!
		ELSE
			Create Files
		END
		
		FOR    ${allfile}    IN    @{anyfiles}
        	Log    ${allfile}
    	END

	
	ELSE
		Log    Directory does not exist.

		Create Directory    ${DIR}
		Log    Directory is created.

		Create Files

		${files}=    List Files In Directory    ${DIR}

		FOR    ${allfile}    IN    @{files}
        	Log    ${allfile}
    	END
	END

Create Files
    FOR	${index}	IN RANGE	1	11
		${file}=	Generate Random String    12    [LOWER]
		${filename}=	Set Variable    ${file}.txt
		Create File	${DIR}/${filename}
	END	
