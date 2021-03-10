import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../services/repository/santri_repository/santri_repository.dart';
import '../bloc/create_izin_cubit.dart';
import '../../../../models/pembina.dart';
import 'choose_santri_step.dart';
import 'final_izin_step.dart';
import 'izin_form_step.dart';

class CreateIzinPage extends StatelessWidget{
  final Pembina pembina;

  const CreateIzinPage({Key key, this.pembina}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => CreateIzinCubit(
            SantriRepository()
          ),
          child: CreateIzinStepper(pembina: pembina,),
        ),
      ),
    );
  }
}

class CreateIzinStepper extends StatelessWidget {
  final Pembina pembina;

  const CreateIzinStepper({Key key, this.pembina}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<CreateIzinCubit, CreateIzinState>(
        builder: (context, state) {
          return Container(
            height: height,
            child: CoolStepper(
                onCompleted: () {},
                showErrorSnackbar: true,
                config: CoolStepperConfig(
                  finalText: "Kirim",
                ),
                steps: [
                  CoolStep(
                    title: "Pilih santri",
                    subtitle: "",
                    validation: (){
                      if (state.idSantri == null || state.idSantri == '') {
                        print(state.idSantri);
                        return "Santri belum dipilih";
                      }
                      return null;
                    },
                    content: ChooseSantriStep(dormitory: pembina.dormitory),
                  ),
                  CoolStep(
                    title: "Form izin",
                    subtitle: "",
                    validation: (){
                      if (state.status.isSubmissionFailure){
                        return "Isi form dengan lengkap";
                      }
                      return null;
                    },
                    content: IzinFormStep(),
                  ),
                  CoolStep(
                    title: "Final",
                    subtitle: "",
                    validation: (){},
                    content: FinalIzinStep(),
                  ),
              ],
            ),
          );
        },
    );
  }
}

