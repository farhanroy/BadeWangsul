import 'package:bade_wangsul/src/modules/pembina/izin/view/choose_pengasuh_step.dart';
import 'package:bade_wangsul/src/modules/pembina/izin/view/choose_santri_step.dart';
import 'package:bade_wangsul/src/modules/pembina/izin/view/final_izin_step.dart';
import 'package:bade_wangsul/src/modules/pembina/izin/view/izin_form_step.dart';
import 'package:flutter/material.dart';

class CreateIzinPage extends StatefulWidget {
  @override
  _CreateIzinPageState createState() => _CreateIzinPageState();
}

class _CreateIzinPageState extends State<CreateIzinPage> {
  var currentStep = 0;

  @override
  Widget build(BuildContext context) {

    List<Step> steps = [
      Step(
        title: Text(''),
        content: ChooseSantriStep(),
        state: currentStep == 0 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: ChoosePengasuhStep(),
        state: currentStep == 1 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: IzinFormStep(),
        state: currentStep == 2 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: FinalIzinStep(),
        state: currentStep == 3 ? StepState.complete : StepState.indexed,
        isActive: true,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Stepper(
          physics: ClampingScrollPhysics(),
          currentStep: this.currentStep,
          type: StepperType.horizontal,
          steps: steps,
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
          onStepContinue: () {
            setState(() {
              if (currentStep < steps.length - 1) {
                currentStep++;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currentStep > 0) {
                currentStep = currentStep - 1;
              } else {
                currentStep = 0;
              }
            });
          },
        ),
      ),
    );
  }
}
