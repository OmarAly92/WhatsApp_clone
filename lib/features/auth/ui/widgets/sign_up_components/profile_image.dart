part of '../../sign_up_screen.dart';


class _ProfileImage extends StatelessWidget {
  const _ProfileImage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Center(
        child: Stack(
          children: [
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
              buildWhen: (previous, current) {
                if (current is AuthenticationProfileImageChanged) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: 165.r,
                  width: 165.r,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: (state is AuthenticationProfileImageChanged)
                        ? Image.file(
                            File(state.profileImage),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            kDefaultProfilePicture,
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                );
              },
            ),
            Positioned(
              top: 100.h,
              left: 120.w,
              child: Container(
                width: 45.r,
                height: 45.r,
                decoration: BoxDecoration(
                  color: const Color(0xff01aa84),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationCubit>(context).pickImageFromGallery();
                  },
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
