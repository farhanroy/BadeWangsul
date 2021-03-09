import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/create_izin_cubit.dart';
import '../../../../models/pembina.dart';
import 'choose_pengasuh_step.dart';
import 'choose_santri_step.dart';
import 'final_izin_step.dart';
import 'izin_form_step.dart';

class CreateIzinPage extends StatefulWidget {
  final Pembina pembina;

  const CreateIzinPage({Key key, this.pembina}) : super(key: key);
  @override
  _CreateIzinPageState createState() => _CreateIzinPageState();
}

class _CreateIzinPageState extends State<CreateIzinPage> {
  var currentStep = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.pembina.dormitory);
    List<Step> steps = [
      Step(
        title: Text(''),
        content: ChooseSantriStep(dormitory: widget.pembina.dormitory),
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
        child: BlocProvider(
          create: (_) => CreateIzinCubit(),
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
      ),
    );
  }
}
