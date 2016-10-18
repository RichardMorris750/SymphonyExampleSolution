<CODEGEN_FILENAME><Structure_name>_Data.CodeGen.dbc</CODEGEN_FILENAME>
<OPTIONAL_USERTOKEN>RPSDATAFILES= </OPTIONAL_USERTOKEN>
;//****************************************************************************
;//
;// Title:       Symphony_Data.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Template to define structure based Data Object
;//
;// Author:      Richard C. Morris, Synergex Technology Evangelist
;//
;// Copyright (c) 2012, Synergex International, Inc. All rights reserved.
;//
;// Redistribution and use in source and binary forms, with or without
;// modification, are permitted provided that the following conditions are met:
;//
;// * Redistributions of source code must retain the above copyright notice,
;//   this list of conditions and the following disclaimer.
;//
;// * Redistributions in binary form must reproduce the above copyright notice,
;//   this list of conditions and the following disclaimer in the documentation
;//   and/or other materials provided with the distribution.
;//
;// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;// POSSIBILITY OF SUCH DAMAGE.
;//
;//****************************************************************************
;;****************************************************************************
;; WARNING: This code was generated by CodeGen. Any changes that you
;;          make to this code will be overwritten if the code is regenerated!
;;
;; Template author: Richard C. Morris, Synergex Technology Evangelist
;;
;; Template Name:   Symphony Framework : <TEMPLATE>.tpl
;;
;;***************************************************************************
import System
import System.Collections
import System.Collections.Generic
import System.Collections.ObjectModel
import System.Collections.Specialized
import System.Text
import System.Runtime.InteropServices
import System.IO

import Symphony.Conductor.Model
import Symphony.Conductor.Converters

import System.Reflection
import System.Runtime.Serialization
import Newtonsoft.Json


namespace <NAMESPACE>

    ;;define a structure that we can use around the applicaiton

	structure STR<Structure_name>
		.include '<structure_noalias>' repository <RPSDATAFILES>, norecord
	endstructure

	{JsonObject(MemberSerialization.OptIn)}
    public partial class <Structure_name>_Data extends Symphony.Conductor.Model.DataObjectBase

		private cls structure clsstr<Structure_name>
<FIELD_LOOP>
<IF LANGUAGE>		
<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
<IF ALPHA>
<IF NOCHECKBOX>
.align
			public cs<Field_sqlname>, String
</IF NOCHECKBOX>
<IF CHECKBOX>
.align
			public cs<Field_sqlname>, Boolean
</IF CHECKBOX>
</IF ALPHA>
<IF USER>
<IF NOCHECKBOX>
			public cs<Field_sqlname>, String
</IF NOCHECKBOX>
<IF CHECKBOX>
.align
			public cs<Field_sqlname>, Boolean
</IF CHECKBOX>
</IF USER>
<IF DECIMAL>
<IF PRECISION>
.align
			public cs<Field_sqlname>, Decimal
</IF PRECISION>
<IF NOPRECISION>
<IF COERCEBOOLEAN>
.align
			public cs<Field_sqlname>, Boolean
<ELSE>
.align
			public cs<Field_sqlname>, Int32
</IF COERCEBOOLEAN>
</IF NOPRECISION>
</IF DECIMAL>
<IF I1>
.align
			public cs<Field_sqlname>, Byte
</IF I1>
<IF I2>
.align
			public cs<Field_sqlname>, Int16
</IF I2>
<IF I4>
.align
			public cs<Field_sqlname>, Int32
</IF I4>
<IF I8>
.align
			public cs<Field_sqlname>, Int64
</IF I8>
<IF DATEORTIME>
<IF DATE_YYYYMMDD>
.align
			public cs<Field_sqlname>, DateTime
</IF DATE_YYYYMMDD>
<IF DATE_YYMMDD>
.align
			public cs<Field_sqlname>, DateTime
</IF DATE_YYMMDD>
<IF DATE_YYJJJ>
.align
			public cs<Field_sqlname>, DateTime
</IF DATE_YYJJJ>
<IF TIME_HHMM>
.align
			public cs<Field_sqlname>, Int16
</IF TIME_HHMM>
<IF TIME_HHMMSS>
.align
			public cs<Field_sqlname>, Int16
</IF TIME_HHMMSS>
</IF DATEORTIME>
<IF BOOLEAN>
.align
			public cs<Field_sqlname>, Boolean
</IF BOOLEAN>
</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
</IF LANGUAGE>		
</FIELD_LOOP>
		endstructure
		
		public static SynergyMemberInfo, @List<System.Reflection.MemberInfo>

		public const RPSStructureName	,String	,"<STRUCTURE_NOALIAS>"
		public const RPSStructureSize	,Int32	,<STRUCTURE_SIZE>

		private <structure_name>_main	,STR<Structure_name>

		private mDoneSynergyRecordValue	,boolean
		
		;;use symphony converters
		private mDateConveter   ,@SynergyDecimalDateConverter ,new SynergyDecimalDateConverter()
		private mAlphaConveter	,@SynergyAlphaConverter ,new SynergyAlphaConverter()
		private mDecimalConveter  ,@SynergyDecimalConverter ,new SynergyDecimalConverter()
		private mImpliedDecimalConveter ,@SynergyImpliedDecimalConverter  ,new SynergyImpliedDecimalConverter()
		private mIntegerConveter  ,@SynergyIntConverter ,new SynergyIntConverter()
		private mAlphaYNConveter	,@SynergyAlphaYNConverter, new SynergyAlphaYNConverter()

		static method <Structure_name>_Data
			endparams
		proc
			data objectType = ^typeof(<Structure_name>_Data)
			SynergyMemberInfo = new List<System.Reflection.MemberInfo>() {
			&	^as(RuntimeReflectionExtensions.GetRuntimeProperty(objectType, "SerializableSynergyRecord"), @System.Reflection.MemberInfo)
			& }
			defineSerialiazableDataElements()

			mStaticFieldList = new List<BaseFieldInformation>()
			mStaticFieldDictionary = new Dictionary<string, int>()
			mStaticFieldNameList = new List<String>()
			mStaticFieldHeadingList = new List<String>()

			<SYMPHONY_LOOPSTART>
			<FIELD_LOOP>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			<SYMPHONY_LOOPINCREMENT>
			<IF NUMERIC>
			staticSetFieldInfo(mStaticFieldList, mStaticFieldDictionary, "<FIELD_SQLNAME>", "<Field_sqlname>",  "<FIELD_CHANGEM>", "<FIELD_ARRIVEM>",
			&	"<FIELD_LEAVEM>", "<FIELD_ORIGINAL_NAME>", <FIELD_POSITION>, <FIELD_SIZE>,
			&	<FIELD_ELEMENT0>, 0, 0, 0,
			&	"<FIELD_TYPE_NAME>", <IF REQUIRED>true</IF><IF OPTIONAL>false</IF>, <FIELD_MINVALUE>, <FIELD_MAXVALUE>)
			<ELSE>
			staticSetFieldInfo(mStaticFieldList, mStaticFieldDictionary, "<FIELD_SQLNAME>", "<Field_sqlname>",  "<FIELD_CHANGEM>", "<FIELD_ARRIVEM>",
			&	"<FIELD_LEAVEM>", "<FIELD_ORIGINAL_NAME>", <FIELD_POSITION>, <FIELD_SIZE>,
			&	<FIELD_ELEMENT0>, 0, 0, 0,
			&	"<FIELD_TYPE_NAME>", <IF REQUIRED>true</IF><IF OPTIONAL>false</IF>, 0, 0)
			</IF NUMERIC>

			</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			</FIELD_LOOP>

			<FIELD_LOOP>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			mStaticFieldNameList.Add("<Field_sqlname>")
			mStaticFieldHeadingList.Add("<FIELD_HEADING>")
			</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			</FIELD_LOOP>

			mreturn
		endmethod
		
		private partial static method defineSerialiazableDataElements, void
		endmethod

        ;;; <summary>
        ;;;  Constructor, initialise the base fields
        ;;; </summary>
        public method <Structure_name>_Data
            endparams
            parent()
        proc
			mDoneSynergyRecordValue = true
			doingClearFocus = false

			configureFieldInfo()
			setFieldNames()
			InitData()
			mDoneSynergyRecordValue = false
			extendedConstructor()
        endmethod

        ;;; <summary>
        ;;; Alternate constructor, accepts the inital value to assign to the object
        ;;; </summary>
        ;;; <param name="synRec">Provide the data to load into the _DATAOBJECT_</param>
        public method <Structure_name>_Data
            in req synRec       ,String
            endparams
            parent()
        proc
			mDoneSynergyRecordValue = true
			doingClearFocus = false

			mIsNew = false
			configureFieldInfo()
			setFieldNames()
			<structure_name>_main = synRec
			;OriginalSynergyRecord = synRec
			extendedConstructor()
        endmethod

		;;; <summary>
		;;; Alternate constructor, accepts the inital value to assign to the object
		;;; </summary>
		;;; <param name="synRec">Provide the data to load into the _DATAOBJECT_</param>
		public method <Structure_name>_Data
			in req synRec       ,STR<Structure_name>
			endparams
			parent()
		proc
			mDoneSynergyRecordValue = true
			doingClearFocus = false

			mIsNew = false
			configureFieldInfo()
			setFieldNames()
			<structure_name>_main = synRec
			;OriginalSynergyRecord = synRec
			extendedConstructor()
		endmethod

		;;; <summary>
		;;; Alternate constructor, accepts the inital value to assign to the object.
		;;; Also accepts the boolean value to assign to the ObjectRaisesPropertyChanged property.
		;;; </summary>
		;;; <param name="synRec">Provide the data to load into the _DATAOBJECT_</param>
		;;; <param name="notifyUI">values passed onto the ObjectRaisesPropertyChanged property.</param>
		public method <Structure_name>_Data
			in req synRec       ,String
			in req notifyUI		,DataObjectNotificationState
			endparams
			parent()
		proc
			mDoneSynergyRecordValue = true
			doingClearFocus = false

			ObjectRaisesPropertyChanged = notifyUI
			mIsNew = false
			configureFieldInfo()
			setFieldNames()
			<structure_name>_main = synRec
			;OriginalSynergyRecord = synRec
			extendedConstructor()
		endmethod

		;;; <summary>
		;;; Alternate constructor, accepts the inital value to assign to the object.
		;;; Also accepts the boolean value to assign to the ObjectRaisesPropertyChanged property.
		;;; </summary>
		;;; <param name="synRec">Provide the data to load into the _DATAOBJECT_</param>
		;;; <param name="notifyUI">values passed onto the ObjectRaisesPropertyChanged property.</param>
		public method <Structure_name>_Data
			in req synRec       ,STR<Structure_name>
			in req notifyUI		,DataObjectNotificationState
			endparams
			parent()
		proc
			mDoneSynergyRecordValue = true
			doingClearFocus = false

			ObjectRaisesPropertyChanged = notifyUI
			mIsNew = false
			configureFieldInfo()
			setFieldNames()
			<structure_name>_main = synRec
;			OriginalSynergyRecord = synRec
			extendedConstructor()
		endmethod

        ;;Set up the arrays of field details
        private method configureFieldInfo	,void
			endparams
		proc
			
			mfieldArray = mStaticFieldList
			mfieldDictionary = mStaticFieldDictionary

		endmethod

		private static mStaticFieldList			,@List<BaseFieldInformation>
		private static mStaticFieldDictionary	,@Dictionary<string, int>
		private static mStaticFieldNameList		,@List<String>
		private static mStaticFieldHeadingList	,@List<String>

        ;;Set up the arrays of field names and headings
        private method setFieldNames	,void
			endparams
		proc

			mFieldNames = mStaticFieldNameList
			mFieldHeadings = mStaticFieldHeadingList
			
		endmethod

        ;;Expose fields as properties for data binding
        <SYMPHONY_LOOPSTART>
        <FIELD_LOOP>
		<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
        ;;<Field_name>
		{JsonProperty}
		public property <Field_sqlname>, <field_spec>
			method get
			proc
				<IF ALPHA>
				mreturn %atrim(<structure_name>_main.<Field_name>)
                <ELSE>
				<IF DATE_YYYYMMDD>
				<IF DATETODAY>
				if (!sStructure_name>_main.<Field_name>)
					<structure_name>_main.<Field_name> = Symphony.Conductor.Converters.DefaultValues.TodayYYYYMMDD()
				</IF DATETODAY>
				</IF DATE_YYYYMMDD>
                mreturn <structure_name>_main.<Field_name>
				</IF ALPHA>
            endmethod
			method set
			proc
				<IF USER>
				if (<structure_name>_main.<Field_name> .nes. value)
				<ELSE>
				<IF ALPHA>
					if (<structure_name>_main.<Field_name> .nes. value)
				<ELSE>
				if (<structure_name>_main.<Field_name> .ne. value)
				</IF ALPHA>
				</IF USER>
				begin
					<SYMPHONY_LOOPINCREMENT>;//increment the loop
					<structure_name>_main.<Field_name> = value
					ValidateEnteredData(<SYMPHONY_LOOPVALUE>)
					RaisePropertyChanged("<Field_sqlname>")
					<IF ALPHA>
					<IF ARRAY>
					RaisePropertyChanged("<Field_basename>")
					</IF ARRAY>
                    </IF ALPHA>
				end
			endmethod
		endproperty
		</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
        </FIELD_LOOP>
			
        ;;; <summary>
        ;;; Expose the complete synergy record
        ;;; </summary>
		public override property SynergyRecord, String
            method get
            proc
                mreturn (String)<Structure_name>_main
            endmethod
            method set
            proc
				if (!mDoneSynergyRecordValue)
					OriginalSynergyRecord = value

				mDoneSynergyRecordValue = true
				
				setUsed()
                <Structure_name>_main = value

                ;;Signal that all fields have changed
                <SYMPHONY_LOOPSTART>
                <FIELD_LOOP>
				<IF LANGUAGE>
				<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
				SetFieldValid("<Field_sqlname>")
				<SYMPHONY_LOOPINCREMENT>	;//increment the loop
				if (mValidateSynergyData) ValidateEnteredData(<SYMPHONY_LOOPVALUE>)
				</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
                </IF LANGUAGE>
                </FIELD_LOOP>
				RaisePropertyChanged(^null)
				RaiseSynergyRecordChanged()
            endmethod
        endproperty

        ;;; <summary>
        ;;; Allow the host to initialise all fields.
        ;;; </summary>
        public override method InitData ,void
        proc
			init <Structure_name>_main

			<FIELD_LOOP>
			<IF LANGUAGE>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			<IF DEFAULT>
			<IF ALPHA>
			<structure_name>_main.<Field_name> = "<FIELD_DEFAULT>"
			<ELSE>
			<structure_name>_main.<Field_name> = <FIELD_DEFAULT>
			</IF ALPHA>
			</IF DEFAULT>
			</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			</IF LANGUAGE>
			</FIELD_LOOP>
			RaisePropertyChanged(^null)
			parent.InitData()
        endmethod

        ;;; <summary>
        ;;; Allow the host to validate all fields. Each field will fire the validation method.
        ;;; </summary>
        public override method InitialValidateData, void
            endparams
        proc
			<SYMPHONY_LOOPSTART>
            <FIELD_LOOP>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			<SYMPHONY_LOOPINCREMENT>	;//increment the loop
            ValidateEnteredData(<SYMPHONY_LOOPVALUE>)
            RaisePropertyChanged("<Field_sqlname>")
			</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
            </FIELD_LOOP>

        endmethod

        ;;; <summary>
        ;;; Indicate from the UI which field now has focus. This then signals the
        ;;; CurrentFieldInfo change event so the UI can get the current field details
        ;;; </summary>
        ;;; <param name="fieldName">Name of field with focus</param>
        public override method SetFieldFocusFlag    ,void
            in req fieldName                        ,String
            endparams
        proc
            using fieldName select
			<SYMPHONY_LOOPSTART>
            <FIELD_LOOP>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			<SYMPHONY_LOOPINCREMENT>
            ("<FIELD_ORIGINAL_NAME>"), mCurrentField = <SYMPHONY_LOOPVALUE>
			</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
            </FIELD_LOOP>
            (),
                mCurrentField = 0
            endusing
            RaisePropertyChanged("CurrentFieldInfo")
        endmethod

        ;;; <summary>
        ;;; Expose information about the current field
        ;;; </summary>
        ;;; <returns>Current field information</returns>
        public property CurrentFieldInfo    ,String
            method get
            proc
                using mCurrentField select
				<SYMPHONY_LOOPSTART>
                <FIELD_LOOP>
				<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
				<SYMPHONY_LOOPINCREMENT>
                (<SYMPHONY_LOOPVALUE>),    mreturn "<FIELD_INFOLINE>"
				</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
                </FIELD_LOOP>
				(), mreturn ""  ;;if incorrect field value or not configured, ensure we clear the return value
                endusing
            endmethod
        endproperty

        ;;Expose properties to indicate whether fields are enabled
        <SYMPHONY_LOOPSTART>
        <FIELD_LOOP>
		<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
		<SYMPHONY_LOOPINCREMENT>

        public property <Field_sqlname>IsEnabled, Boolean
            method get
            proc
                mreturn GetFieldEnabledState(<SYMPHONY_LOOPVALUE>)
            endmethod
            method set
            proc
                SetFieldEnabledState(<SYMPHONY_LOOPVALUE>, value)
                RaiseNonRPSPropertyChanged("<Field_sqlname>IsEnabled")
            endmethod
        endproperty
		</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
        </FIELD_LOOP>

        ;;Expose properties to indicate whether fields are focussed
        <FIELD_LOOP>
		<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
		private m<Field_sqlname>IsFocused	,Boolean
		public property <Field_sqlname>IsFocused, Boolean
			method get
			proc
				mreturn m<Field_sqlname>IsFocused
			endmethod
			method set
			proc
				clearFocus()
				m<Field_sqlname>IsFocused = value
				RaiseNonRPSPropertyChanged("<Field_sqlname>IsFocused")
			endmethod
		endproperty
		</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
        </FIELD_LOOP>

        ;;Expose properties to indicate whether fields are read only
		<SYMPHONY_LOOPSTART>
		<FIELD_LOOP>
		<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
		<SYMPHONY_LOOPINCREMENT>

		public property <Field_sqlname>IsReadOnly, Boolean
			method get
			proc
				mreturn GetFieldReadOnlyState(<SYMPHONY_LOOPVALUE>)
			endmethod
			method set
			proc
				SetFieldReadOnlyState(<SYMPHONY_LOOPVALUE>, value)
				RaiseNonRPSPropertyChanged("<Field_sqlname>IsReadOnly")
			endmethod
		endproperty
		</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
        </FIELD_LOOP>

		private doingClearFocus	,Boolean

		private method clearFocus, void
			endparams
		proc
			if (!doingClearFocus)
			begin
				doingClearFocus = true
				<FIELD_LOOP>
				<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
				if (<Field_sqlname>IsFocused) <Field_sqlname>IsFocused = false
				</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
                </FIELD_LOOP>
				doingClearFocus = false
			end
		endmethod

		public method FieldErrorDetails	,void
			in req fldName				,String
			in req errorText			,String
			endparams
		proc
			setErrorDetails(fldName, errorText)
			RaisePropertyChanged(fldName)
		endmethod

		public method FieldValidDetails	,void
			in req fldName				,String
			endparams
		proc
			SetFieldValid(fldName)
			RaisePropertyChanged(fldName)
		endmethod

		public override method CompareObjects	,int
			in req obj1							,@Object
			in req obj2							,@Object
			in req colName						,String
			in req sortDir						,Symphony.Conductor.Framework.SynergySortOrder
			endparams

			record
				result		,int
			endrecord
		proc
			using colName select
			<FIELD_LOOP>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			("<Field_sqlname>"),
			begin
				if (((<Structure_name>_Data)obj1).<Field_sqlname> == ((<Structure_name>_Data)obj2).<Field_sqlname>) then
					result = 0
				else
				begin
					if (((<Structure_name>_Data)obj1).<Field_sqlname> > ((<Structure_name>_Data)obj2).<Field_sqlname>) then
					begin
						if (sortDir == Symphony.Conductor.Framework.SynergySortOrder.Ascending) then
							result = -1
						else
							result = 1
					end
					else
					begin
						if (sortDir == Symphony.Conductor.Framework.SynergySortOrder.Descending) then
							result = -1
						else
							result = 1
					end
				end
			end
			</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
            </FIELD_LOOP>
			(),
				result = this.CustomCompareObjects(obj1, obj2, colName, sortDir)
			endusing

			mreturn result
		endmethod
		
.region "Serialization over Symphony Bridge"
		
		
		{JsonProperty}
		public property SerializableSynergyRecord, [#]byte
			method get
			proc
				data tmpSTR	,clsstr<Structure_name>
<FIELD_LOOP>
<IF LANGUAGE>		
<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
<IF ALPHA>
<IF NOCHECKBOX>
				tmpSTR.cs<Field_sqlname> = (string)mAlphaConveter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
</IF NOCHECKBOX>
<IF CHECKBOX>
				tmpSTR.cs<Field_sqlname> = (boolean)mAlphaYNConveter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
</IF CHECKBOX>
</IF ALPHA>
<IF USER>
<IF NOCHECKBOX>
				tmpSTR.cs<Field_sqlname> = (string)mAlphaConveter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
</IF NOCHECKBOX>
<IF CHECKBOX>
				tmpSTR.cs<Field_sqlname> = (boolean)mAlphaYNConveter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
</IF CHECKBOX>
</IF USER>
<IF DECIMAL>
<IF PRECISION>
				tmpSTR.cs<Field_sqlname> = (decimal)mImpliedDecimalConveter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
</IF PRECISION>
<IF NOPRECISION>
<IF COERCEBOOLEAN>
				tmpSTR.cs<Field_sqlname> = (boolean)mDecimalTFConverter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
<ELSE>
				tmpSTR.cs<Field_sqlname> = (int32)mIntegerConveter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
</IF COERCEBOOLEAN>
</IF NOPRECISION>
</IF DECIMAL>
<IF I1>
				tmpSTR.cs<Field_sqlname> = (Byte)mIntegerConveter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
</IF I1>
<IF I2>
				tmpSTR.cs<Field_sqlname> = (int16)mIntegerConveter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
</IF I2>
<IF I4>
				tmpSTR.cs<Field_sqlname> = (int32)mIntegerConveter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
</IF I4>
<IF I8>
				tmpSTR.cs<Field_sqlname> = (int64)mIntegerConveter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
</IF I8>
<IF DATEORTIME>
<IF DATE_YYYYMMDD>
				if (<structure_name>_main.<field_name>)
					tmpSTR.cs<Field_sqlname> = (datetime?)mDateConveter.Convert(<structure_name>_main.<field_name>, ^null, "FORMAT:YYYYMMDD<IF NOTDATETODAY>|NODEFAULTODAY</IF>", ^null)
</IF DATE_YYYYMMDD>
<IF DATE_YYMMDD>
				if (<structure_name>_main.<field_name>)
					tmpSTR.cs<Field_sqlname> = (datetime?)mDateConveter.Convert(<structure_name>_main.<field_name>, ^null, "FORMAT:YYMMDD<IF NOTDATETODAY>|NODEFAULTODAY</IF>", ^null)
</IF DATE_YYMMDD>
<IF DATE_YYJJJ>
				if (<structure_name>_main.<field_name>)
					tmpSTR.cs<Field_sqlname> = (datetime?)mDateConveter.Convert(<structure_name>_main.<field_name>, ^null, "FORMAT:JULIAN<IF NOTDATETODAY>|NODEFAULTODAY</IF>", ^null)
</IF DATE_YYJJJ>
<IF TIME_HHMM>
				tmpSTR.cs<Field_sqlname> = (int)mIntegerConveter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
</IF TIME_HHMM>
<IF TIME_HHMMSS>
				tmpSTR.cs<Field_sqlname> = (int)mIntegerConveter.Convert(<structure_name>_main.<field_name>, ^null, ^null, ^null)
</IF TIME_HHMMSS>
</IF DATEORTIME>
<IF BOOLEAN>
				tmpSTR.cs<Field_sqlname> = <structure_name>_main.<field_name>
</IF BOOLEAN>
</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
</IF LANGUAGE>		
</FIELD_LOOP>
				mreturn structureToByteArray(tmpSTR)
			endmethod
			method set
			proc
				data tmpSTR	,clsstr<Structure_name>
				tmpSTR = byteArrayToStructure(value)
<FIELD_LOOP>
<IF LANGUAGE>		
<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
<IF USER>
<IF NOCHECKBOX>
				<structure_name>_main.<Field_name> = (a)mAlphaConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null)
</IF NOCHECKBOX>
<IF CHECKBOX>
				<structure_name>_main.<Field_name> = (a)mAlphaYNConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null)
</IF CHECKBOX>
</IF USER>
<IF ALPHA>
<IF NOCHECKBOX>
				<structure_name>_main.<Field_name> = (a)mAlphaConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null)
</IF NOCHECKBOX>
<IF CHECKBOX>
				<structure_name>_main.<Field_name> = (a)mAlphaYNConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null)
</IF CHECKBOX>
</IF ALPHA>
<IF DECIMAL>
<IF PRECISION>
				<structure_name>_main.<Field_name> = (id)mImpliedDecimalConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null)
</IF PRECISION>
<IF NOPRECISION>
<IF COERCEBOOLEAN>
				<structure_name>_main.<Field_name> = (d)mDecimalTFConverter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null)
<ELSE>
				<structure_name>_main.<Field_name> = (d)((i)mIntegerConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null))
</IF COERCEBOOLEAN>
</IF NOPRECISION>
</IF DECIMAL>
<IF I1>
				<structure_name>_main.<Field_name> = (i)mIntegerConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null)
</IF I1>
<IF I2>
				<structure_name>_main.<Field_name> = (i)mIntegerConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null)
</IF I2>
<IF I4>
				<structure_name>_main.<Field_name> = (i)mIntegerConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null)
</IF I4>
<IF I8>
				<structure_name>_main.<Field_name> = (i)mIntegerConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null)
</IF I8>
<IF DATEORTIME>
<IF DATE_YYYYMMDD>
				<structure_name>_main.<Field_name> = (d)mDateConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, "FORMAT:YYYYMMDD<IF NOTDATETODAY>|NODEFAULTODAY</IF>", ^null)
</IF DATE_YYYYMMDD>
<IF DATE_YYMMDD>
				<structure_name>_main.<Field_name> = (d)mDateConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, "FORMAT:YYMMDD<IF NOTDATETODAY>|NODEFAULTODAY</IF>", ^null)
</IF DATE_YYMMDD>
<IF DATE_YYJJJ>
				<structure_name>_main.<Field_name> = (d)mDateConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, "FORMAT:JULIAN<IF NOTDATETODAY>|NODEFAULTODAY</IF>", ^null)
</IF DATE_YYJJJ>
<IF TIME_HHMM>
				<structure_name>_main.<Field_name> = (d)mIntegerConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null)
</IF TIME_HHMM>
<IF TIME_HHMMSS>
				<structure_name>_main.<Field_name> = (d)mIntegerConveter.ConvertBack(tmpSTR.cs<Field_sqlname>, ^null, ^null, ^null)
</IF TIME_HHMMSS>
</IF DATEORTIME>
<IF BOOLEAN>
				<structure_name>_main.<Field_name> = tmpSTR.cs<Field_sqlname>
</IF BOOLEAN>
</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
</IF LANGUAGE>		
</FIELD_LOOP>
			endmethod
		endproperty
			
		private static method structureToByteArray	,[#]byte
			tmpSTRUCT				,clsstr<Structure_name>
			endparams
		proc
			data stream	,@MemoryStream , new MemoryStream()
			begin
				disposable data writer ,@BinaryWriter , new BinaryWriter(stream)
<FIELD_LOOP>
<IF LANGUAGE>		
<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
<IF USER>
<IF NOCHECKBOX>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>)
</IF NOCHECKBOX>
<IF CHECKBOX>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString())
</IF CHECKBOX>
</IF USER>
<IF ALPHA>
<IF NOCHECKBOX>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>)
</IF NOCHECKBOX>
<IF CHECKBOX>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString())
</IF CHECKBOX>
</IF ALPHA>
<IF DECIMAL>
<IF PRECISION>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString())
</IF PRECISION>
<IF NOPRECISION>
<IF COERCEBOOLEAN>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString())
<ELSE>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString())
</IF COERCEBOOLEAN>
</IF NOPRECISION>
</IF DECIMAL>
<IF I1>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString())
</IF I1>
<IF I2>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString())
</IF I2>
<IF I4>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString())
</IF I4>
<IF I8>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString())
</IF I8>
<IF DATEORTIME>
<IF DATE_YYYYMMDD>
				if (tmpSTRUCT.cs<Field_sqlname>.Ticks >= DateTime.MinValue.Ticks && tmpSTRUCT.cs<Field_sqlname>.Ticks <= DateTime.MaxValue.Ticks) then
					writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'"))
				else
					writer.Write("")
</IF DATE_YYYYMMDD>
<IF DATE_YYMMDD>
				if (tmpSTRUCT.cs<Field_sqlname>.Ticks >= DateTime.MinValue.Ticks && tmpSTRUCT.cs<Field_sqlname>.Ticks <= DateTime.MaxValue.Ticks) then
					writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'"))
				else
					writer.Write("")
</IF DATE_YYMMDD>
<IF DATE_YYJJJ>
				if (tmpSTRUCT.cs<Field_sqlname>.Ticks >= DateTime.MinValue.Ticks && tmpSTRUCT.cs<Field_sqlname>.Ticks <= DateTime.MaxValue.Ticks) then
					writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'fff'Z'"))
				else
					writer.Write("")
</IF DATE_YYJJJ>
<IF TIME_HHMM>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString())
</IF TIME_HHMM>
<IF TIME_HHMMSS>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString())
</IF TIME_HHMMSS>
</IF DATEORTIME>
<IF BOOLEAN>
				writer.Write(tmpSTRUCT.cs<Field_sqlname>.ToString())
</IF BOOLEAN>
</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
</IF LANGUAGE>		
</FIELD_LOOP>
			end
			mreturn stream.ToArray()
		endmethod
		
		private static method byteArrayToStructure	,clsstr<Structure_name>
			bytearray, [#]byte  
			endparams
		proc
			data tmpString	,string
			data tmpSTRUCT	,clsstr<Structure_name>
			data stream	,@MemoryStream	,new MemoryStream(byteArray)
			begin
				disposable data reader	,@BinaryReader	,new BinaryReader(stream)
<FIELD_LOOP>
<IF LANGUAGE>		
<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
<IF ALPHA>
<IF NOCHECKBOX>
				tmpSTRUCT.cs<Field_sqlname> = reader.ReadString()
</IF NOCHECKBOX>
<IF CHECKBOX>
				tmpString = reader.ReadString()
				tmpSTRUCT.cs<Field_sqlname> = Convert.ToBoolean(tmpString)
</IF CHECKBOX>
</IF ALPHA>
<IF USER>
<IF NOCHECKBOX>
				tmpSTRUCT.cs<Field_sqlname> = reader.ReadString()
</IF NOCHECKBOX>
<IF CHECKBOX>
				tmpString = reader.ReadString()
				tmpSTRUCT.cs<Field_sqlname> = Convert.ToBoolean(tmpString)
</IF CHECKBOX>
</IF USER>
<IF DECIMAL>
<IF PRECISION>
				tmpString = reader.ReadString()
				tmpSTRUCT.cs<Field_sqlname> = Convert.ToDecimal(tmpString)
</IF PRECISION>
<IF NOPRECISION>
<IF COERCEBOOLEAN>
				tmpString = reader.ReadString()
				tmpSTRUCT.cs<Field_sqlname> = Convert.ToBoolean(tmpString)
<ELSE>
				tmpString = reader.ReadString()
				tmpSTRUCT.cs<Field_sqlname> = Convert.ToInt32(tmpString)
</IF COERCEBOOLEAN>
</IF NOPRECISION>
</IF DECIMAL>
<IF I1>
				tmpString = reader.ReadString()
				tmpSTRUCT.cs<Field_sqlname> = Convert.ToInt16(tmpString)
</IF I1>
<IF I2>
				tmpString = reader.ReadString()
				tmpSTRUCT.cs<Field_sqlname> = Convert.ToInt16(tmpString)
</IF I2>
<IF I4>
				tmpString = reader.ReadString()
				tmpSTRUCT.cs<Field_sqlname> = Convert.ToInt32(tmpString)
</IF I4>
<IF I8>
				tmpString = reader.ReadString()
				tmpSTRUCT.cs<Field_sqlname> = Convert.ToInt64(tmpString)
</IF I8>
<IF DATEORTIME>
<IF DATE_YYYYMMDD>
				tmpString = reader.ReadString()
				if (tmpString.Length > 0) tmpSTRUCT.cs<Field_sqlname> = Convert.ToDateTime(tmpString)
</IF DATE_YYYYMMDD>
<IF DATE_YYMMDD>
				tmpString = reader.ReadString()
				if (tmpString.Length > 0) tmpSTRUCT.cs<Field_sqlname> = Convert.ToDateTime(tmpString)
</IF DATE_YYMMDD>
<IF DATE_YYJJJ>
				tmpString = reader.ReadString()
				if (tmpString.Length > 0) tmpSTRUCT.cs<Field_sqlname> = Convert.ToDateTime(tmpString)
</IF DATE_YYJJJ>
<IF TIME_HHMM>
				tmpString = reader.ReadString()
				tmpSTRUCT.cs<Field_sqlname> = Convert.ToInt32(tmpString)
</IF TIME_HHMM>
<IF TIME_HHMMSS>
				tmpString = reader.ReadString()
				tmpSTRUCT.cs<Field_sqlname> = Convert.ToInt32(tmpString)
</IF TIME_HHMMSS>
</IF DATEORTIME>
<IF BOOLEAN>
				tmpString = reader.ReadString()
				tmpSTRUCT.cs<Field_sqlname> = Convert.ToBoolean(tmpString)
</IF BOOLEAN>
</IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
</IF LANGUAGE>		
</FIELD_LOOP>
			end

			mreturn tmpSTRUCT
		endmethod
		
		public override property StructureSize	,Int32
			method get
			proc
				mreturn RPSStructureSize
			endmethod
		endproperty

.endregion
		
	endclass
endnamespace

